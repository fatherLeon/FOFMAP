//
//  UserInfoUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/12.
//

import Foundation

struct User {
    let nickname: String
    let id: String
    let level: Int
    let grade: String
    let gardeDate: String
}

struct UserInfoUseCase: DetailFetchable {
    typealias T = User
    
    private let offerableUseCase: Offerable
    private let nickname: String
    
    init(offerableUseCase: Offerable = FetchUseCase(), nickname: String) {
        self.offerableUseCase = offerableUseCase
        self.nickname = nickname
    }
    
    func execute() async throws -> User {
        let (id, level) = try await offerableUseCase.getUserInfo(by: nickname)
        
    }
}
