//
//  NetworkManager.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/28.
//

import Foundation

struct NetworkManager: Connectable {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func request(with urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await session.data(for: urlRequest)
        
        try checkCorrrectResponse(response)
        
        return (data, response)
    }
    
    private func checkCorrrectResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.httpError
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.responseError(statusCode: httpResponse.statusCode)
        }
    }
}
