//
//  DetailPlayerUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/17.
//

import UIKit

struct DetailPlayerUseCase: DetailFetchable {
    
    typealias T = PlayerInfo?
    
    private let offerableUseCase: Offerable
    private let targetPlayer: Player
    
    init(targetPlayer: Player, offerableUseCase: Offerable = FetchUseCase()) {
        self.targetPlayer = targetPlayer
        self.offerableUseCase = offerableUseCase
    }
    
    func execute() async throws -> PlayerInfo? {
        guard let name = try? await getPlayerName(),
              let seasonImg = try? await getPlayerSeasonImage(),
              let playerImg = try? await getPlayerImage(),
              let position = PlayerSection.getPosition(by: targetPlayer.spPosition) else {
            return nil
        }
        
        return PlayerInfo(id: targetPlayer.spID, name: name, spGrade: targetPlayer.spGrade, seasonImg: seasonImg, img: playerImg, positionId: targetPlayer.spPosition, position: position)
    }
    
    private func getPlayerImage() async throws -> UIImage {
        return try await offerableUseCase.getPlayerActionImage(by: targetPlayer.spID)
    }
    
    private func getPlayerSeasonImage() async throws -> UIImage {
        return try await offerableUseCase.getSeasonImage(by: targetPlayer.spID)
    }
    
    private func getPlayerName() async throws -> String {
        return try await offerableUseCase.getPlayerName(by: targetPlayer.spID)
    }
}
