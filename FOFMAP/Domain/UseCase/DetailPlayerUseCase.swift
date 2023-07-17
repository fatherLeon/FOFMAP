//
//  DetailPlayerUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/17.
//

import UIKit

struct DetailPlayerUseCase: DetailFetchable {
    
    typealias T = PlayerInfo
    
    private let offerableUseCase: Offerable
    private let targetPlayer: Player
    
    init(targetPlayer: Player, offerableUseCase: Offerable = FetchUseCase()) {
        self.targetPlayer = targetPlayer
        self.offerableUseCase = offerableUseCase
    }
    
    func execute() async throws -> PlayerInfo {
        guard let name = try? await getPlayerName(),
              let seasonImg = try? await getPlayerSeasonImage(),
              let position = PlayerSection.getPosition(by: targetPlayer.spPosition) else {
            return PlayerInfo(id: targetPlayer.spID, name: "", spGrade: targetPlayer.spGrade, seasonImg: UIImage(systemName: "list.bullet.rectangle.fill")!, img: UIImage(systemName: "person.fill")!, positionId: targetPlayer.spPosition, position: .goalkeeper)
        }
        
        let playerActionImg = try? await getPlayerActionImage()
        let playerImg = try? await getPlayerImage()
        let playerImage = playerActionImg ?? playerImg ?? UIImage(systemName: "person.fill")!
        
        return PlayerInfo(id: targetPlayer.spID, name: name, spGrade: targetPlayer.spGrade, seasonImg: seasonImg, img: playerImage, positionId: targetPlayer.spPosition, position: position)
    }
    
    private func getPlayerImage() async throws -> UIImage {
        return try await offerableUseCase.getPlayerImage(by: targetPlayer.spID)
    }
    
    private func getPlayerActionImage() async throws -> UIImage {
        return try await offerableUseCase.getPlayerActionImage(by: targetPlayer.spID)
    }
    
    private func getPlayerSeasonImage() async throws -> UIImage {
        return try await offerableUseCase.getSeasonImage(by: targetPlayer.spID)
    }
    
    private func getPlayerName() async throws -> String {
        return try await offerableUseCase.getPlayerName(by: targetPlayer.spID)
    }
}
