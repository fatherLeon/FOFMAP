//
//  FetchNetworkUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import UIKit

struct FetchNetworkUseCase {
    private let provider: Providable
    
    init(provider: Providable = APIProvider()) {
        self.provider = provider
    }
    
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
    
    func getMatchDescAllPlayers(matchId: String) async throws -> [Player] {
        guard let url = ContentType.matchDesc(matchId: matchId).url else {
            throw NetworkError.urlError
        }
        var players: [Player] = []
        let matchDesc = try await provider.receiveData(url: url, by: MatchDesc.self)
        
        matchDesc.matchInfo.forEach { matchInfo in
            players += matchInfo.player
        }
        
        return players
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
    
    func getSeasonImage(by spid: Int) async throws -> UIImage {
        let index = "\(spid)".index("\(spid)".startIndex, offsetBy: 3)
        let seasonId = String("\(spid)".prefix(upTo: index))
        
        guard let url = ContentType.metaSeasonId.url else {
            throw NetworkError.urlError
        }
        
        let seasonIds = try await provider.receiveData(url: url, by: MetaSeasonIds.self)
        
        guard let filteredSeason = seasonIds.first(where: { "\($0.seasonId)" == seasonId }),
              let url = URL(string: filteredSeason.seasonImgURL) else {
            throw NetworkError.invalidData
        }
        
        let seasonImage = try await provider.receiveImage(by: url)
        
        return seasonImage
    }
    
    func getPlayerActionImage(by spid: Int) async throws -> UIImage {
        guard let url = ContentType.metaPlayerActionshotImageBySpid(spid: spid).url else {
            throw NetworkError.urlError
        }
        
        let actionImage = try await provider.receiveImage(by: url)
        
        return actionImage
    }
}
