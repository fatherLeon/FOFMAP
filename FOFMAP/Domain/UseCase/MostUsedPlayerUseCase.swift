//
//  MostUsedPlayerUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import Combine
import Foundation

final class MostUsedPlayerUseCase: NetworkUseCaseProtocol {
    typealias T = [PlayerInfo]
    
    private let usedPlayersNum = 30
    private let networkingUseCase = FetchNetworkUseCase()
    
    func execute() async throws -> T {
        var mostUsedPlayers: [PlayerInfo] = []
        
        let usedPlayers = try await getAllUsedPlayer()
        
        for (id, value) in usedPlayers {
            if mostUsedPlayers.count > usedPlayersNum {
                break
            }
            
            async let name = try? networkingUseCase.getPlayerName(by: id)
            async let actionImage = try? networkingUseCase.getPlayerActionImage(by: id)
            async let seasonImage = try? networkingUseCase.getSeasonImage(by: id)
            
            guard let name = await name,
                  let actionImage = await actionImage,
                  let seasonImage = await seasonImage,
                  let position = PlayerSection.getPosition(by: value.position) else { continue }
            
            mostUsedPlayers.append(PlayerInfo(id: id, name: name, seasonImg: seasonImage, img: actionImage, position: position))
        }
        
        return mostUsedPlayers
    }
    
    private func getAllUsedPlayer() async throws -> [Int: (count: Int, position: Int)] {
        var usedPlayers: [Int: (count: Int, position: Int)] = [:]
        let matcheIds = try await networkingUseCase.getAllMatches(50, offset: 0, limit: 50, orderBy: .desc)
        
        for id in matcheIds {
            let players = try await networkingUseCase.getMatchDescAllPlayers(matchId: id)
            
            players.forEach { player in
                if usedPlayers[player.spID] != nil {
                    usedPlayers[player.spID]?.count += 1
                    return
                }
                
                usedPlayers[player.spID] = (1, player.spPosition)
            }
        }
        
        return usedPlayers
    }
}
