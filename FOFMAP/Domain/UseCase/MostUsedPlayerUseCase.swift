//
//  MostUsedPlayerUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import Combine
import Foundation

final class MostUsedPlayerUseCase {
    private let networkingUseCase = FetchNetworkUseCase()
    private var usedPlayers: [Int: Int] = [:]
    
    func execute() async throws -> [PlayerInfo] {
        var mostUsedPlayers: [PlayerInfo] = []
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
            
            guard let name = try? await networkingUseCase.getPlayerName(by: id),
                  let actionImage = try? await networkingUseCase.getPlayerActionImage(by: id),
                  let seasonImage = try? await networkingUseCase.getSeasonImage(by: id) else {
                continue
            }
            
            mostUsedPlayers.append(PlayerInfo(name: name, seasonImg: seasonImage, img: actionImage))
        }
        
        return mostUsedPlayers
    }
}
