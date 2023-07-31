//
//  FetchNetworkUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import UIKit

protocol Offerable {
    // 유저
    func getUserInfo(by nickname: String) async throws -> (accessID: String, level: Int)
    func getUserMatchIds(accessId: String, matchType: Int, offset: Int, limit: Int) async throws -> UserMatches
    func getUserBestGrade(accessId: String) async throws -> UserGrade
    
    // 매치
    func getAllMatches(_ matchtype: Int, offset: Int, limit: Int, orderBy: ContentType.OrderBy) async throws -> [String]
    func getMatchDesc(matchId: String) async throws -> MatchDesc
    func getMatchDescAllPlayers(matchId: String) async throws -> [Player]
    
    // 메타
    func getPlayerName(by spid: Int) async throws -> String
    func getSeasonImage(by spid: Int) async throws -> UIImage
    func getPlayerImage(by spid: Int) async throws -> UIImage
    func getPlayerActionImage(by spid: Int) async throws -> UIImage
    func getMetaDivisionGrade(gradeId: Int) async throws -> String
}

struct FetchUseCase: Offerable {
    private let provider: Providable
    
    init(provider: Providable = APIProvider()) {
        self.provider = provider
    }
    
    // MARK: 유저정보
    func getUserInfo(by nickname: String) async throws -> (accessID: String, level: Int) {
        guard let url = ContentType.userInfo(nickname: nickname).url else {
            throw NetworkError.urlError
        }
        
        let userInfo = try await provider.receiveData(url: url, isCached: false, by: UserInfo.self)
        
        return (userInfo.id, userInfo.level)
    }
    
    func getUserMatchIds(accessId: String, matchType: Int, offset: Int, limit: Int) async throws -> UserMatches {
        guard let url = ContentType.userMatches(id: accessId, matchType: matchType, offset: offset, limit: limit).url else {
            throw NetworkError.urlError
        }
        
        let matchIds = try await provider.receiveData(url: url, isCached: false, by: UserMatches.self)
        
        return matchIds
    }
    
    func getUserBestGrade(accessId: String) async throws -> UserGrade {
        guard let url = ContentType.userMaxGrade(id: accessId).url else {
            throw NetworkError.urlError
        }
        
        let userGrades = try await provider.receiveData(url: url, isCached: false, by: UserGrade.self)
        
        return userGrades
    }
    
    // MARK: 매치정보
    func getAllMatches(_ matchtype: Int, offset: Int, limit: Int, orderBy: ContentType.OrderBy = .desc) async throws -> [String] {
        guard let url = ContentType.matchAllRecord(matchType: matchtype, offset: offset, limit: limit, orderBy: orderBy).url else {
            throw NetworkError.urlError
        }
        
        let allMatchIDs = try await provider.receiveData(url: url, isCached: false, by: MatchAllRecord.self)
        
        return allMatchIDs
    }
    
    func getMatchDesc(matchId: String) async throws -> MatchDesc {
        guard let url = ContentType.matchDesc(matchId: matchId).url else {
            throw NetworkError.urlError
        }
        
        let matchDesc = try await provider.receiveData(url: url, isCached: false, by: MatchDesc.self)
        
        return matchDesc
    }
    
    func getMatchDescAllPlayers(matchId: String) async throws -> [Player] {
        guard let url = ContentType.matchDesc(matchId: matchId).url else {
            throw NetworkError.urlError
        }
        let matchDesc = try await provider.receiveData(url: url, isCached: false, by: MatchDesc.self)
        var players: [Player] = []
        
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
        
        let players = try await provider.receiveData(url: url, isCached: true, by: MetaPlayerIds.self)
        
        guard let filteredPlayer = players.first(where: { $0.id == spid }) else {
            throw NetworkError.invalidData
        }
                
        return filteredPlayer.name
    }
    
    func getSeasonImage(by spid: Int) async throws -> UIImage {
        guard let url = ContentType.metaSeasonId.url else {
            throw NetworkError.urlError
        }
        
        let seasonId = spid / 1000000
        let seasonIds = try await provider.receiveData(url: url, isCached: true, by: MetaSeasonIds.self)
        
        guard let filteredSeason = seasonIds.first(where: { $0.seasonId == seasonId }),
              let url = URL(string: filteredSeason.seasonImgURL) else {
            throw NetworkError.invalidData
        }
        
        let seasonImage = try await provider.receiveImage(isCached: false, by: url)
        
        return seasonImage
    }
    
    func getPlayerActionImage(by spid: Int) async throws -> UIImage {
        let seasonId = spid / 1000000
        let pid = spid - (seasonId * 1000000)
        
        guard let pidUrl = ContentType.metaPlayerActionshotImageByPid(pid: pid).url,
              let spidUrl = ContentType.metaPlayerActionshotImageBySpid(spid: spid).url else {
            throw NetworkError.urlError
        }
        
        let actionImageBySpid = try? await provider.receiveImage(isCached: false, by: spidUrl)
        if let image = actionImageBySpid {
            return image
        }
        
        let actionImageByPid = try? await provider.receiveImage(isCached: false, by: pidUrl)
        if let image = actionImageByPid {
            return image
        }
        
        throw NetworkError.invalidData
    }
    
    func getPlayerImage(by spid: Int) async throws -> UIImage {
        let seasonId = spid / 1000000
        let pid = spid - (seasonId * 1000000)
        
        guard let pidUrl = ContentType.metaPlayerImageByPid(pid: pid).url,
              let spidUrl = ContentType.metaPlayerImageBySpid(spid: spid).url else {
            throw NetworkError.urlError
        }
        
        let imageBySpid = try? await provider.receiveImage(isCached: false, by: spidUrl)
        if let image = imageBySpid {
            return image
        }
        
        let imageByPid = try? await provider.receiveImage(isCached: false, by: pidUrl)
        if let image = imageByPid {
            return image
        }

        throw NetworkError.invalidData
    }
    
    func getMetaDivisionGrade(gradeId: Int) async throws -> String {
        guard let url = ContentType.metaGrade.url else {
            throw NetworkError.urlError
        }
        
        let grades = try await provider.receiveData(url: url, isCached: true, by: MetaGrades.self)
        
        guard let gradeName = grades.first(where: { $0.divisionId == gradeId })?.divisionName else {
            return "등급 정보 없음"
        }
        
        return gradeName
    }
}
