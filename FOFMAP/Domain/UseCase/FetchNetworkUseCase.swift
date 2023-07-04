//
//  FetchNetworkUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import Foundation

class FetchNetworkUseCase {
    private let provider = APIProvider()
    
    // MARK: 유저정보
    func getUserInfo(by nickname: String) async throws -> (accessID: String, level: Int) {
        guard let url = ContentType.userInfo(nickname: nickname).url else {
            throw NetworkError.urlError
        }
        
        let userInfo = try await provider.receiveData(url: url, by: UserInfo.self)
        
        return (userInfo.id, userInfo.level)
    }
    
    // MARK: 매치정보
    func getAllMatches(_ matchtype: Int, offset: Int, limit: Int, orderBy: ContentType.OrderBy = .desc) async throws -> [String] {
        guard let url = ContentType.matchAllRecord(matchType: matchtype, offset: offset, limit: limit, orderBy: orderBy).url else {
            throw NetworkError.urlError
        }
        
        let allMatchIDs = try await provider.receiveData(url: url, by: MatchAllRecord.self)
        
        return allMatchIDs
    }
    
    // MARK: 메타정보
    func getPlayerName(by spid: Int) async throws -> String {
        guard let url = ContentType.metaPlayerId.url else {
            throw NetworkError.urlError
        }
        
        let players = try await provider.receiveData(url: url, by: MetaPlayerIds.self)
        guard let filteredPlayer = players.first(where: { $0.id == spid }) else {
            throw NetworkError.invalidData
        }
        
        return filteredPlayer.name
    }
}
