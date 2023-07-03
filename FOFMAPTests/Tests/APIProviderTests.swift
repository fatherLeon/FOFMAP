//
//  APIProviderTests.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/03.
//

@testable
import FOFMAP
import XCTest

final class APIProviderTests: XCTestCase {
    
    private var sut: APIProvider!
    private var networkManager: MockNetworkManager!
    private var cacheManager: MockCacheManager!
    private let sampleURL = URL(string: "www.naver.com")!

    override func setUpWithError() throws {
        self.networkManager = MockNetworkManager()
        self.cacheManager = MockCacheManager()
        sut = APIProvider(connectable: networkManager, cacheStorable: cacheManager)
    }

    override func tearDownWithError() throws {
        self.networkManager = nil
        self.cacheManager = nil
        sut = nil
    }

    func test_canParsingUserTradeHistorySample() async throws {
        // given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = SampleData.userTradeHistoryData
            
            return (response, data)
        }
        
        let expectationMethodCalledCount = 1
        let expectationDataCount = 2
        
        // when
        let tradeHistory = try await sut.receiveData(url: sampleURL, by: UserTradeHistory.self)
        
        // then
        XCTAssertEqual(expectationDataCount, tradeHistory.count)
        self.networkManager.testCheckingCalledRequestNumber(expectationMethodCalledCount)
    }
    
    func test_failParsingSampleDataByIncorrectType() async throws {
        // given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = SampleData.userTradeHistoryData
            
            return (response, data)
        }
        
        let expectationMethodCalledCount = 1
        let expectationError = NetworkError.incorrectType
        
        // when
        // then
        do {
            let tradeHistory = try await sut.receiveData(url: sampleURL, by: MatchAllRecord.self)
            XCTFail("This testcase must throw IncorrectType Error")
        } catch {
            XCTAssertEqual(expectationError, error as! NetworkError)
            self.networkManager.testCheckingCalledRequestNumber(expectationMethodCalledCount)
        }
    }
    
//    func test_canParsingSampleImage() async throws {
//        // given
//        MockURLProtocol.requestHandler = { request in
//            let response = HTTPURLResponse(url: self.sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
//
//            // Image Data
//        }
//
//        let expectationMethodCalledCount = 1
//        let expectationImage = UIImage()
//
//        // when
//        let resultImage = try await sut.receiveImage(by: sampleURL)
//
//        // then
//        XCTAssertEqual(expectationImage, resultImage)
//        self.networkManager.testCheckingCalledRequestNumber(expectationMethodCalledCount)
//    }
}
