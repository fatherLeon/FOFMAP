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
    private var cancellables = Set<AnyCancellable>()
    private let matchType: MatchCategory
    private var offset = 20
    private var limit = 5
    
    @Published var matches: [MatchDesc] = []
    @Published var nickname: String = ""
    @Published var error: UserError? = nil
    @Published var isErrorShownAlert = false
    @Published var isPossibleFetch = false
    
    @MainActor
    init(matchType: MatchCategory, recordUseCase: any DetailFetchable) {
        self.matchType = matchType
        self.recordUseCase = recordUseCase
        
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
            guard let newMatches = try await self?.recordUseCase.execute() as? [MatchDesc] else {
                self?.isPossibleFetch = false
                return
            }
            
            newMatches.forEach { match in
                self?.matches.append(match)
            }
            
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
            if info.nickname != self.nickname {
                opponentUserName = info.nickname
            }
        }
        
        return opponentUserName
    }
    
    func getScoreText(by match: MatchDesc) -> String {
        var myGoal = 0
        var opponentGoal = 0
        
        match.matchInfo.forEach { matchInfo in
            if matchInfo.nickname == nickname {
                myGoal = matchInfo.shoot["goalTotal"] ?? 0
            } else {
                opponentGoal = matchInfo.shoot["goalTotal"] ?? 0
            }
        }
        
        return "\(myGoal) : \(opponentGoal)"
    }
    
    @MainActor
    private func binding() {
        $nickname
            .sink(receiveValue: { nickname in
                Task { [weak self] in
                    do {
                        guard let matches = try await self?.recordUseCase.execute() as? [MatchDesc] else {
                            return
                        }
                        
                        self?.matches = matches
                        self?.isPossibleFetch = true
                    } catch {
                        self?.error = error as? UserError
                        self?.isErrorShownAlert = true
                    }
                }
            })
            .store(in: &cancellables)
    }
}
