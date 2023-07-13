//
//  RecordViewModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Combine
import Foundation

final class RecordViewModel: ObservableObject {
    
    private var recordUseCase: any DetailFetchable
    private var userInfoUseCase: any DetailFetchable
    private var cancellables = Set<AnyCancellable>()
    private let matchType: MatchCategory
    private var offset = 20
    private var limit = 5
    
    @Published var user: User = User(nickname: "", id: "", level: 0, grade: "", gradeDate: "")
    @Published var matches: [MatchDesc] = []
    @Published var nickname: String = ""
    @Published var error: UserError? = nil
    @Published var isErrorShownAlert = false
    @Published var isPossibleFetch = false
    
    @MainActor
    init(matchType: MatchCategory, recordUseCase: any DetailFetchable, userInfoUseCase: any DetailFetchable) {
        self.matchType = matchType
        self.recordUseCase = recordUseCase
        self.userInfoUseCase = userInfoUseCase
        
        binding()
    }
    
    func isLastItem(_ match: MatchDesc) -> Bool {
        guard let lastMatch = matches.last else {
            return false
        }
        
        if lastMatch.matchID == match.matchID {
            return true
        }
        
        return false
    }
    
    @MainActor
    func getAdditionalRecordMatches() {
        guard matches.isEmpty == false else { return }
        
        offset += limit
        recordUseCase = UserMatchRecordUseCase(nickname: nickname, matchType: matchType, offset: offset, limit: limit)
        
        Task { [weak self] in
            guard let newMatches = try await self?.recordUseCase.execute() as? [MatchDesc],
                  newMatches.isEmpty == false else {
                self?.isPossibleFetch = false
                return
            }
            
            self?.matches += newMatches
            self?.isPossibleFetch = true
        }
    }
    
    func getYearToDayText(by match: MatchDesc) -> String {
        return Date.toYearMonthDateString(match.matchDate)
    }
    
    func getHourToMinute(by match: MatchDesc) -> String {
        return Date.toHourMinuteString(match.matchDate)
    }
    
    func getOpponentUserName(by match: MatchDesc) -> String {
        var opponentUserName = ""
        
        match.matchInfo.forEach { info in
            if info.nickname.uppercased() != self.nickname.uppercased() {
                opponentUserName = info.nickname
            }
        }
        
        return opponentUserName
    }
    
    func getScoreText(by match: MatchDesc) -> (player: Int, opponent: Int) {
        var myGoal = 0
        var opponentGoal = 0
        
        match.matchInfo.forEach { matchInfo in
            if matchInfo.nickname == nickname {
                myGoal = matchInfo.shoot["goalTotal"] ?? 0
            } else {
                opponentGoal = matchInfo.shoot["goalTotal"] ?? 0
            }
        }
        
        return (myGoal, opponentGoal)
    }
    
    @MainActor
    private func binding() {
        $nickname
            .sink(receiveValue: { [weak self] nickname in
                Task { [weak self] in
                    guard let user = try await self?.userInfoUseCase.execute() as? User else {
                        self?.error = UserError.noExistUser
                        self?.isErrorShownAlert = true
                        self?.isPossibleFetch = false
                        
                        return
                    }
                    
                    self?.user = user
                    
                    do {
                        guard let matches = try await self?.recordUseCase.execute() as? [MatchDesc] else { return }
                        
                        self?.matches = matches
                        self?.isPossibleFetch = true
                    } catch {
                        self?.error = UserError.noExistMatchRecord
                        self?.isErrorShownAlert = true
                        self?.isPossibleFetch = false
                    }
                }
            })
            .store(in: &cancellables)
    }
}
