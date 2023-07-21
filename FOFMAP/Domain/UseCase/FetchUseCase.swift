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
        
        let userInfo = try await provider.receiveData(url: url, by: UserInfo.self)
        
        return (userInfo.id, userInfo.level)
    }
    
    func getUserMatchIds(accessId: String, matchType: Int, offset: Int, limit: Int) async throws -> UserMatches {
        guard let url = ContentType.userMatches(id: accessId, matchType: matchType, offset: offset, limit: limit).url else {
            throw NetworkError.urlError
        }
        
        let matchIds = try await provider.receiveData(url: url, by: UserMatches.self)
        
        return matchIds
    }
    
    func getUserBestGrade(accessId: String) async throws -> UserGrade {
        guard let url = ContentType.userMaxGrade(id: accessId).url else {
            throw NetworkError.urlError
        }
        
        let userGrades = try await provider.receiveData(url: url, by: UserGrade.self)
        
        return userGrades
    }
    
    // MARK: 매치정보
    func getAllMatches(_ matchtype: Int, offset: Int, limit: Int, orderBy: ContentType.OrderBy = .desc) async throws -> [String] {
        guard let url = ContentType.matchAllRecord(matchType: matchtype, offset: offset, limit: limit, orderBy: orderBy).url else {
            throw NetworkError.urlError
        }
        
        let allMatchIDs = try await provider.receiveData(url: url, by: MatchAllRecord.self)
        
        return allMatchIDs
    }
    
    func getMatchDesc(matchId: String) async throws -> MatchDesc {
        guard let url = ContentType.matchDesc(matchId: matchId).url else {
            throw NetworkError.urlError
        }
        
        let matchDesc = try await provider.receiveData(url: url, by: MatchDesc.self)
        
        return matchDesc
    }
    
    func getMatchDescAllPlayers(matchId: String) async throws -> [Player] {
        guard let url = ContentType.matchDesc(matchId: matchId).url else {
            throw NetworkError.urlError
        }
        let matchDesc = try await provider.receiveData(url: url, by: MatchDesc.self)
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
        
        let players = try await provider.receiveData(url: url, by: MetaPlayerIds.self)
        
        guard let filteredPlayer = players.first(where: { $0.id == spid }) else {
            throw NetworkError.invalidData
        }
                
        return filteredPlayer.name
    }
    
    func getSeasonImage(by spid: Int) async throws -> UIImage {
        let seasonId = spid / 1000000
        
        guard let url = ContentType.metaSeasonId.url else {
            throw NetworkError.urlError
        }
        
        let seasonIds = try await provider.receiveData(url: url, by: MetaSeasonIds.self)
        
        guard let filteredSeason = seasonIds.first(where: { $0.seasonId == seasonId }),
              let url = URL(string: filteredSeason.seasonImgURL) else {
            throw NetworkError.invalidData
        }
        
        let seasonImage = try await provider.receiveImage(by: url)
        
        return seasonImage
    }
    
    func getPlayerActionImage(by spid: Int) async throws -> UIImage {
        let seasonId = spid / 1000000
        let pid = spid - (seasonId * 1000000)
        
        guard let pidUrl = ContentType.metaPlayerActionshotImageByPid(pid: pid).url,
              let spidUrl = ContentType.metaPlayerActionshotImageBySpid(spid: spid).url else {
            throw NetworkError.urlError
        }
        
        let actionImageByPid = try? await provider.receiveImage(by: pidUrl)
        let actionImageBySpid = try? await provider.receiveImage(by: spidUrl)
        
        guard let actionImage = actionImageBySpid ?? actionImageByPid else {
            throw NetworkError.invalidData
        }
        
        return actionImage
    }
    
    func getPlayerImage(by spid: Int) async throws -> UIImage {
        let seasonId = spid / 1000000
        let pid = spid - (seasonId * 1000000)
        
        guard let pidUrl = ContentType.metaPlayerImageByPid(pid: pid).url,
              let spidUrl = ContentType.metaPlayerImageBySpid(spid: spid).url else {
            throw NetworkError.urlError
        }
        
        let imageByPid = try? await provider.receiveImage(by: pidUrl)
        let imageBySpid = try? await provider.receiveImage(by: spidUrl)
        
        guard let image = imageBySpid ?? imageByPid else {
            throw NetworkError.invalidData
        }
        
        return image
    }
    
    func getMetaDivisionGrade(gradeId: Int) async throws -> String {
        guard let url = ContentType.metaGrade.url else {
            throw NetworkError.urlError
        }
        
        let grades = try await provider.receiveData(url: url, by: MetaGrades.self)
        
        guard let gradeName = grades.first(where: { $0.divisionId == gradeId })?.divisionName else {
            return "등급 정보 없음"
        }
        
        return gradeName
    }
}
