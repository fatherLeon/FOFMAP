//
//  UserInfoUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Foundation

struct UserInfoUseCase: DetailFetchable {
    typealias T = UserInfo
    
    private let offerableUseCase: Offerable
    private let name: String
    
    init(name: String, offerableUseCase: Offerable = FetchUseCase()) {
        self.name = name
        self.offerableUseCase = offerableUseCase
    }
    
    func execute() async throws -> UserInfo {
        let (id, level) = try await offerableUseCase.getUserInfo(by: name)
        
        return UserInfo(id: id, nickname: name, level: level)
    }
}
