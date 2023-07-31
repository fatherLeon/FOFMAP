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
        
        let expectationNetworkManagerMethodCalledCount = 1
        let expectationCacheManagerMethodCalledCount = 0
        let expectationDataCount = 2
        
        // when
        let tradeHistory = try await sut.receiveData(url: sampleURL, isCached: false, by: UserTradeHistory.self)
        
        // then
        XCTAssertEqual(expectationDataCount, tradeHistory.count)
        self.networkManager.testCheckingCalledRequestNumber(expectationNetworkManagerMethodCalledCount)
        self.cacheManager.testCheckingStoreCache(expectationCacheManagerMethodCalledCount)
    }
    
    func test_failParsingSampleDataByIncorrectType() async throws {
        // given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = SampleData.userTradeHistoryData
            
            return (response, data)
        }
        
        let expectationMethodCalledCount = 1
        
        // when
        // then
        do {
            let _ = try await sut.receiveData(url: sampleURL, isCached: true, by: MatchAllRecord.self)
            XCTFail("This testcase must throw IncorrectType Error")
        } catch {
            self.networkManager.testCheckingCalledRequestNumber(expectationMethodCalledCount)
            self.cacheManager.testCheckingStoreCache(expectationMethodCalledCount)
        }
    }
    
    func test_canParsingSampleImage() async throws {
        // given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = UIImage(systemName: "person.fill")!.pngData()!
            
            return (response, data)
        }

        let expectationMethodCalledCount = 1
        let storeCacheMethodCalledCount = 0
        let expectationImageData = UIImage(systemName: "person.fill")!.pngData()!

        // when
        let resultImage = try await sut.receiveImage(isCached: false, by: sampleURL)

        // then
        self.networkManager.testCheckingCalledRequestNumber(expectationMethodCalledCount)
        self.cacheManager.testCheckingStoreCache(storeCacheMethodCalledCount)
    }
    
    func test_failParsingSampleImageByInvalidData() async throws {
        // given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = SampleData.userTradeHistoryData
            
            return (response, data)
        }
        
        let expectationMethodCalledCount = 1
        let expectationError = NetworkError.invalidData
        // when
        // then
        
        do {
            let _ = try await sut.receiveImage(isCached: true, by: sampleURL)
            XCTFail("This testcase must throw InvalidData Error")
        } catch {
            XCTAssertEqual(expectationError, error as! NetworkError)
            self.networkManager.testCheckingCalledRequestNumber(expectationMethodCalledCount)
            self.cacheManager.testCheckingStoreCache(expectationMethodCalledCount)
        }
    }
    
    // 시나리오 1 - 똑같은 request 호출 2번 시 storeCache 1번, getCachedResponse 1번
    func test_scenario1() async throws {
        // given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = SampleData.userTradeHistoryData
            
            return (response, data)
        }
        
        let expectationCalledMethodCount = 1
        // when
        let _ = try await sut.receiveData(url: sampleURL, isCached: true, by: UserTradeHistory.self)
        
        // then
        networkManager.testCheckingCalledRequestNumber(expectationCalledMethodCount)
        cacheManager.testCheckingStoreCache(expectationCalledMethodCount)
        cacheManager.testCheckingGetCachedResponse(expectationCalledMethodCount)
    }
}
