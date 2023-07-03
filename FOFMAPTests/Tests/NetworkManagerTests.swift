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
    
    private var sut: NetworkManager!
    private let sampleURL = URL(string: "www.naver.com")!

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
            let response = HTTPURLResponse(url: self.sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let stubData = SampleData.userTradeHistoryData
            
            return (response, stubData)
        }
        
        let request = URLRequest(url: sampleURL)
        let expectationData = SampleData.userTradeHistoryData
        let expectationStatusCode = 200
        
        // when
        let (resultData, response) = try await sut.request(with: request)
        let httpResponse = response as! HTTPURLResponse
        
        // then
        XCTAssertEqual(expectationData, resultData)
        XCTAssertEqual(expectationStatusCode, httpResponse.statusCode)
    }
    
    func test_isFailedResponseByStatusCode403_and_ErrorIsResponseError403() async {
        // given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.sampleURL, statusCode: 403, httpVersion: nil, headerFields: nil)!
            let stubData = SampleData.userTradeHistoryData
            
            return (response, stubData)
        }
        
        let request = URLRequest(url: sampleURL)
        let expectationError = NetworkError.responseError(statusCode: 403)
        
        // when
        // then
        do {
            let _ = try await self.sut.request(with: request)
            XCTFail("This testcase must throw Response Error")
        } catch {
            XCTAssertEqual(expectationError, error as! NetworkError)
        }
    }
}
