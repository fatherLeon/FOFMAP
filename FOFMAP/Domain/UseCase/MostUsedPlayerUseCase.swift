//
//  MostUsedPlayerUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import Combine
import Foundation

struct MostUsedPlayerUseCase: DetailFetchable {
    typealias T = [PlayerInfo]
    
    private let usedPlayersNum: Int
    private let offerableUseCase: Offerable
    private var offset: Int = 0
    private let limit = 20
    
    init(boundaryUsedPlayerNum: Int = 30, offerableUseCase: Offerable = FetchUseCase()) {
        self.offerableUseCase = offerableUseCase
        self.usedPlayersNum = boundaryUsedPlayerNum
    }
    
    func execute() async throws -> [PlayerInfo] {
        let usedPlayers = try await getAllUsedPlayer()
        var mostUsedPlayers: [PlayerInfo] = []
        
        for (id, value) in usedPlayers {
            if mostUsedPlayers.count >= usedPlayersNum {
                return mostUsedPlayers
            }
            
            async let name = try? offerableUseCase.getPlayerName(by: id)
            async let actionImage = try? offerableUseCase.getPlayerActionImage(by: id)
            async let seasonImage = try? offerableUseCase.getSeasonImage(by: id)
            
            guard let name = await name,
                  let actionImage = await actionImage,
                  let seasonImage = await seasonImage,
                  let position = PlayerSection.getPosition(by: value.position) else { continue }
            
            mostUsedPlayers.append(PlayerInfo(id: id, name: name, seasonImg: seasonImage, img: actionImage, positionId: value.position, position: position))
        }
        
        if mostUsedPlayers.isEmpty {
            throw UserError.noExistMostUsedPlayers
        } else {
            return mostUsedPlayers
        }
    }
    
    private func getAllUsedPlayer() async throws -> [Int: (count: Int, position: Int)] {
        let matcheIds = try await offerableUseCase.getAllMatches(50, offset: offset, limit: limit, orderBy: .desc)
        var usedPlayers: [Int: (count: Int, position: Int)] = [:]
        
        for id in matcheIds {
            let players = try await offerableUseCase.getMatchDescAllPlayers(matchId: id)
            
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
