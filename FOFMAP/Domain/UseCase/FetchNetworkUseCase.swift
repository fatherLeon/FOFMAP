//
//  FetchNetworkUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import Foundation

class FetchNetworkUseCase {
    private let provider = APIProvider()
    
    func getUserInfo(by nickname: String) async throws -> (accessID: String, level: Int) {
        guard let url = ContentType.userInfo(nickname: nickname).url else {
            throw NetworkError.urlError
        }
        
        let userInfo = try await provider.receiveData(url: url, by: UserInfo.self)
        
        return (userInfo.id, userInfo.level)
    }
    
    
}
