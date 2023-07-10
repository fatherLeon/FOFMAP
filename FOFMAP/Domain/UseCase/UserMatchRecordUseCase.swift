//
//  MatchRecordUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Foundation

struct UserMatchRecordUseCase: DetailFetchable {
    typealias T = [MatchDesc]
    
    private let offerableUseCase: Offerable
    private let nickname: String
    
    init(nickname: String, offerableUseCase: Offerable = FetchUseCase()) {
        self.nickname = nickname
        self.offerableUseCase = offerableUseCase
    }
    
    func execute() async throws -> [MatchDesc] {
        return []
    }
    
    private func getUserInfo(name: String) async throws -> UserInfo {
        let (id, level) = try await offerableUseCase.getUserInfo(by: name)
        
        return UserInfo(id: id, nickname: name, level: level)
    }
    
    private func getUserMatchIds(userId: String, matchType: Int, offset: Int, limit: Int) async throws -> UserMatches {
        let matchIds = try await offerableUseCase.getUserMatchIds(accessId: userId, matchType: matchType, offset: offset, limit: limit)
        
        return matchIds
    }
}
