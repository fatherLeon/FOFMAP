//
//  MockNetworkManager.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/03.
//

@testable
import FOFMAP
import XCTest
import Foundation

final class MockNetworkManager: Connectable {
    
    private let session: URLSession
    private var calledRequestMethodNum = 0
    
    init() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        self.session = session
    }
    
    func request(with urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await session.data(for: urlRequest)
        self.calledRequestMethodNum += 1
        
        return (data, response)
    }
    
    func testCheckingCalledRequestNumber(_ expectation: Int) {
        XCTAssertEqual(expectation, calledRequestMethodNum)
    }
}
