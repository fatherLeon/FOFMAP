//
//  RecordViewModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Combine
import Foundation

final class RecordViewModel: ObservableObject {
    
    private let recordUseCase: any DetailFetchable
    private var cancellables = Set<AnyCancellable>()
    
    @Published var matches: [MatchDesc] = []
    @Published var nickname: String = ""
    @Published var error: UserError? = nil
    @Published var isErrorShownAlert = false
    
    @MainActor
    init(recordUseCase: any DetailFetchable) {
        self.recordUseCase = recordUseCase
        
        binding()
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
                    } catch {
                        self?.error = error as? UserError
                        self?.isErrorShownAlert = true
                    }
                }
            })
            .store(in: &cancellables)
    }
}
