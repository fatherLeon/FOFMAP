//
//  MockMostUsedPlayerUseCase.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/06.
//

@testable
import FOFMAP
import UIKit

struct StubFetchUseCase: Offerable {
    func getPlayerName(by spid: Int) async throws -> String {
        <#code#>
    }
    
    func getSeasonImage(by spid: Int) async throws -> UIImage {
        <#code#>
    }
    
    func getPlayerActionImage(by spid: Int) async throws -> UIImage {
        <#code#>
    }
    
    func getUserInfo(by nickname: String) async throws -> (accessID: String, level: Int) {
        <#code#>
    }
    
    func getAllMatches(_ matchtype: Int, offset: Int, limit: Int, orderBy: FOFMAP.ContentType.OrderBy) async throws -> [String] {
        <#code#>
    }
    
    func getMatchDescAllPlayers(matchId: String) async throws -> [FOFMAP.Player] {
        <#code#>
    }
}
