//
//  NetworkManager.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/28.
//

import Foundation

struct NetworkManager {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func request(with urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.httpError
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.responseError(statusCode: httpResponse.statusCode)
        }
        
        return data
    }
}
