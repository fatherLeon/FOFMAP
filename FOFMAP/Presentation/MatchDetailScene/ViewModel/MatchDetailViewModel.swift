//
//  MatchDetailViewModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/17.
//

import Foundation

final class MatchDetailViewModel: ObservableObject {
    private let matchDesc: MatchDesc
    private let userName: String
    private var userPlayers: [PlayerInfo] = []
    private var enemyPlayers: [PlayerInfo] = []
    
    @Published var pickerSelection: UserPick = .user
    
    init(userName: String, matchDesc: MatchDesc) {
        self.matchDesc = matchDesc
        self.userName = userName
    }
    
    private func getUserPlayerInfo() {
        guard let userMatchInfo = matchDesc.matchInfo.first(where: { info in
            return info.nickname.uppercased() == self.userName.uppercased()
        }) else { return }
        
        userMatchInfo.player.forEach { player in
            let useCase = DetailPlayerUseCase(targetPlayer: player)
            
            Task { [weak self] in
                guard let playerInfo = try? await useCase.execute() else { return }
                
                self?.userPlayers.append(playerInfo)
            }
        }
    }
    
    private func getEnemyPlayerInfo() {
        guard let enemyMatchInfo = matchDesc.matchInfo.first(where: { info in
            return info.nickname.uppercased() != self.userName.uppercased()
        }) else { return }
        
        enemyMatchInfo.player.forEach { player in
            let useCase = DetailPlayerUseCase(targetPlayer: player)
            
            Task { [weak self] in
                guard let playerInfo = try? await useCase.execute() else { return }
                
                self?.enemyPlayers.append(playerInfo)
            }
        }
    }
}
