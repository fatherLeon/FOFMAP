//
//  MostUsedPlayerUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import Foundation

final class MostUsedPlayerUseCase {
    private let networkingUseCase = FetchNetworkUseCase()
    private var usedPlayers: [Int: Int] = [:]
    
    var mostUsedPlayers: [PlayerInfo] = []
    
    func execute() -> [PlayerInfo] {
        Task {
            let matcheIds = try await networkingUseCase.getAllMatches(50, offset: 0, limit: 100, orderBy: .desc)
            
            for id in matcheIds {
                let players = try await networkingUseCase.getMatchDescAllPlayers(matchId: id)
                
                players.forEach { player in
                    if usedPlayers[player.spID] != nil {
                        usedPlayers[player.spID]? += 1
                        return
                    }
                    
                    usedPlayers[player.spID] = 1
                }
            }
            
            for (id, _) in usedPlayers {
                if mostUsedPlayers.count > 10 {
                    break
                }
                
                let name = try await networkingUseCase.getPlayerName(by: id)
                let actionImage = try await networkingUseCase.getPlayerActionImage(by: id)
                let seasonImage = try await networkingUseCase.getSeasonImage(by: id)
                
                mostUsedPlayers.append(PlayerInfo(name: name, seasonImg: seasonImage, img: actionImage))
            }
        }
        
        return mostUsedPlayers
    }
}
