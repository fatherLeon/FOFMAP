//
//  MockNetworkManager.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/03.
//

@testable
import FOFMAP
import Foundation

struct MockNetworkManager: Connectable {
    
    private let session: URLSession
    
    init() {
        let session = URLSession(configuration: .ephemeral)
        
        session.configuration.protocolClasses = [MockURLProtocol.self]
        
        self.session = session
    }
    
    func request(with urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await session.data(for: urlRequest)
    }
}
