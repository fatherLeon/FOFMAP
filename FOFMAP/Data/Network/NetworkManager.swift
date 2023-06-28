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
    
    func dataTask(with request: URLRequest) async throws -> Data? {
        let result = try await session.data(for: request)
    }
}
