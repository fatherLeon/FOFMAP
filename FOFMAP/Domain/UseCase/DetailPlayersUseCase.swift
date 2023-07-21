//
//  DetailPlayerUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/17.
//

import UIKit

struct DetailPlayersUseCase: DetailFetchable {
    
    typealias T = [PlayerInfo]
    
    private let offerableUseCase: Offerable
    private let targetPlayers: [Player]
    
    init(targetPlayers: [Player], offerableUseCase: Offerable = FetchUseCase()) {
        self.targetPlayers = targetPlayers
        self.offerableUseCase = offerableUseCase
    }
    
    func execute() async throws -> [PlayerInfo] {
        var players: [PlayerInfo] = []
        
        for targetPlayer in targetPlayers {
            if targetPlayer.spPosition == 28 { continue }
            
            let player = await getPlayerInfo(targetPlayer)
            
            players.append(player)
        }
        
        players.sort { lhs, rhs in
            return lhs.status["spRating"] ?? 0 > rhs.status["spRating"] ?? 0
        }
        
        return players
    }
    
    private func getPlayerInfo(_ targetPlayer: Player) async -> PlayerInfo {
        guard let position = PlayerSection.getPosition(by: targetPlayer.spPosition) else {
            return PlayerInfo(id: targetPlayer.spID, name: "", spGrade: targetPlayer.spGrade, seasonImg: UIImage(systemName: "list.bullet.rectangle.fill")!, img: UIImage(systemName: "person.fill")!, positionId: targetPlayer.spPosition, position: .goalkeeper, status: targetPlayer.status)
        }
        
        guard let name = try? await getPlayerName(targetPlayer) else {
            return PlayerInfo(id: targetPlayer.spID, name: "", spGrade: targetPlayer.spGrade, seasonImg: UIImage(systemName: "list.bullet.rectangle.fill")!, img: UIImage(systemName: "person.fill")!, positionId: targetPlayer.spPosition, position: position, status: targetPlayer.status)
        }
        
        guard let seasonImg = try? await getPlayerSeasonImage(targetPlayer) else {
            return PlayerInfo(id: targetPlayer.spID, name: name, seasonImg: UIImage(systemName: "list.bullet.rectangle.fill")!, img: UIImage(systemName: "person.fill")!, positionId: targetPlayer.spPosition, position: .goalkeeper, status: targetPlayer.status)
        }
        
        let playerActionImg = try? await getPlayerActionImage(targetPlayer)
        let playerImg = try? await getPlayerImage(targetPlayer)
        let playerImage = playerActionImg ?? playerImg ?? UIImage(systemName: "person.fill")!
        
        return PlayerInfo(id: targetPlayer.spID, name: name, spGrade: targetPlayer.spGrade, seasonImg: seasonImg, img: playerImage, positionId: targetPlayer.spPosition, position: position, status: targetPlayer.status)
    }
    
    private func getPlayerImage(_ targetPlayer: Player) async throws -> UIImage {
        return try await offerableUseCase.getPlayerImage(by: targetPlayer.spID)
    }
    
    private func getPlayerActionImage(_ targetPlayer: Player) async throws -> UIImage {
        return try await offerableUseCase.getPlayerActionImage(by: targetPlayer.spID)
    }
    
    private func getPlayerSeasonImage(_ targetPlayer: Player) async throws -> UIImage {
        return try await offerableUseCase.getSeasonImage(by: targetPlayer.spID)
    }
    
    private func getPlayerName(_ targetPlayer: Player) async throws -> String {
        return try await offerableUseCase.getPlayerName(by: targetPlayer.spID)
    }
}
