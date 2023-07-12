//
//  MatchRecordUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Foundation

enum UserError: LocalizedError {
    case noExistUser
    case noExistMatchRecord
    
    var errorDescription: String? {
        switch self {
        case .noExistUser:
            return "존재하지 않는 유저입니다."
        case .noExistMatchRecord:
            return "매치기록이 존재하지 않습니다."
        }
    }
}

struct UserMatchRecordUseCase: DetailFetchable {
    typealias T = [MatchDesc]
    
    private let offerableUseCase: Offerable
    private let nickname: String
    private let matchType: MatchCategory
    private var offset: Int
    private var limit: Int
    
    init(nickname: String, matchType: MatchCategory, offset: Int = 0, limit: Int = 20, offerableUseCase: Offerable = FetchUseCase()) {
        self.nickname = nickname
        self.matchType = matchType
        self.offset = offset
        self.limit = limit
        self.offerableUseCase = offerableUseCase
    }
    
    func execute() async throws -> [MatchDesc] {
        do {
            let userInfo = try await getUserInfo(name: nickname)
            let userMatchIds = try await getUserMatchIds(userId: userInfo.id, matchType: matchType, offset: offset, limit: limit)
            
            if userMatchIds.isEmpty {
                throw UserError.noExistMatchRecord
            }
            
            var matches: [MatchDesc] = []
            
            for id in userMatchIds {
                let matchDesc = try await offerableUseCase.getMatchDesc(matchId: id)
                
                matches.append(matchDesc)
            }
            
            return matches
        } catch {
            throw UserError.noExistUser
        }
    }
    
    private func getUserInfo(name: String) async throws -> UserInfo {
        let (id, level) = try await offerableUseCase.getUserInfo(by: name)
        
        return UserInfo(id: id, nickname: name, level: level)
    }
    
    private func getUserMatchIds(userId: String, matchType: MatchCategory, offset: Int, limit: Int) async throws -> UserMatches {
        let matchIds = try await offerableUseCase.getUserMatchIds(accessId: userId, matchType: matchType.matchType, offset: offset, limit: limit)
        
        return matchIds
    }
}
