//
//  MockMostUsedPlayerUseCase.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/06.
//

@testable
import FOFMAP
import UIKit

struct MockFetchUseCase: Offerable {
    static var samplePlayers: [PlayerInfo] = []
    
    func getPlayerName(by spid: Int) async throws -> String {
        return MockFetchUseCase.samplePlayers[spid].name
    }
    
    func getSeasonImage(by spid: Int) async throws -> UIImage {
        return MockFetchUseCase.samplePlayers[spid].seasonImg
    }
    
    func getPlayerActionImage(by spid: Int) async throws -> UIImage {
        return MockFetchUseCase.samplePlayers[spid].img
    }
    
    func getUserInfo(by nickname: String) async throws -> (accessID: String, level: Int) {
        return ("FakeID", 60)
    }
    
    func getAllMatches(_ matchtype: Int, offset: Int, limit: Int, orderBy: FOFMAP.ContentType.OrderBy) async throws -> [String] {
        return ["f", "a", "k", "e"]
    }
    
    func getMatchDescAllPlayers(matchId: String) async throws -> [Player] {
        var players: [Player] = []
        
        MockFetchUseCase.samplePlayers.forEach { playerInfo in
            let player = Player(spID: playerInfo.id, spPosition: 10, spGrade: 10, status: [:])
        }
        
        return players
    }
}
