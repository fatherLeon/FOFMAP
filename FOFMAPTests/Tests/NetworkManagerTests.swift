//
//  NetworkManagerTests.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/02.
//

@testable
import FOFMAP
import XCTest

final class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        sut = NetworkManager(session: session)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_isSuccessResponseByStatusCode200_and_StubData_userTradeHistoryData() async throws {
        // given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "www.naver.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let stubData = StubJsonData.userTradeHistoryData!
            
            return (response, stubData)
        }
        
        let request = URLRequest(url: URL(string: "www.naver.com")!)
        let expectationData = StubJsonData.userTradeHistoryData!
        let expectationStatusCode = 200
        
        // when
        let (resultData, response) = try await sut.request(with: request)
        let httpResponse = response as! HTTPURLResponse
        
        // then
        XCTAssertEqual(expectationData, resultData)
        XCTAssertEqual(expectationStatusCode, httpResponse.statusCode)
    }
}
