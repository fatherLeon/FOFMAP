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
    static var samplePlayers: [PlayerInfo] = [
        PlayerInfo(id: 1, name: "a", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker),
        PlayerInfo(id: 2, name: "b", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker),
        PlayerInfo(id: 3, name: "c", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker),
        PlayerInfo(id: 4, name: "d", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker),
        PlayerInfo(id: 5, name: "e", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker),
        PlayerInfo(id: 6, name: "f", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker),
        PlayerInfo(id: 7, name: "g", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker),
        PlayerInfo(id: 8, name: "h", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker),
        PlayerInfo(id: 9, name: "i", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker),
        PlayerInfo(id: 10, name: "j", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker),
        PlayerInfo(id: 11, name: "k", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!, position: .striker)
    ]
    
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
