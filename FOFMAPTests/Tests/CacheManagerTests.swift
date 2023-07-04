//
//  CacheManagerTests.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/04.
//

@testable
import FOFMAP
import XCTest

final class CacheManagerTests: XCTestCase {
    
    private var sut: CacheManager!
    private let sampleURL = URL(string: "www.naver.com")!

    override func setUpWithError() throws {
        let mockURLCache = MockURLCache()
        
        sut = CacheManager(urlCache: mockURLCache)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_getCachedResponse_return_DataAndURLResponse_after_storeCache() throws {
        // given
        let urlResponse = HTTPURLResponse(url: sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = SampleData.imageData
        let request = URLRequest(url: sampleURL)
        
        // when
        sut.storeCache(response: urlResponse, data: data, in: request)
        
        let (resultData, resultResponse) = sut.getCachedResponse(for: request)!
        
        // then
        XCTAssertEqual(data, resultData)
        XCTAssertEqual(urlResponse, resultResponse)
    }
    
    func test_nothingStoreCache_getCachedResponse_return_nil() {
        // given
        let request = URLRequest(url: sampleURL)
        
        // when
        let result = sut.getCachedResponse(for: request)
        
        // then
        XCTAssertNil(result?.0) // Data
        XCTAssertNil(result?.1) // URLResponse
    }
    
    func test_removeCache_getCachedResponse_return_nil() {
        // given
        let urlResponse = HTTPURLResponse(url: sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = SampleData.imageData
        let request = URLRequest(url: sampleURL)
        
        // when
        sut.storeCache(response: urlResponse, data: data, in: request)
        sut.removeCache(for: request)
        
        let result = sut.getCachedResponse(for: request)
        
        // then
        XCTAssertNil(result)
    }
    
    func test_removeAllCache_before_allGetCachedResponse_return_nil() {
        // given
        let request1 = URLRequest(url: sampleURL)
        let request2 = URLRequest(url: URL(string: "www.daum.net")!)
        
        let response1 = HTTPURLResponse(url: sampleURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let response2 = HTTPURLResponse(url: URL(string: "www.daum.net")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        let data1 = SampleData.imageData
        let data2 = SampleData.userTradeHistoryData
        
        // when
        sut.storeCache(response: response1, data: data1, in: request1)
        sut.storeCache(response: response2, data: data2, in: request2)
        
        sut.removeAllCache()
        
        let resultRequest1 = sut.getCachedResponse(for: request1)
        let resultRequest2 = sut.getCachedResponse(for: request2)
        
        // then
        XCTAssertNil(resultRequest1)
        XCTAssertNil(resultRequest2)
    }
}
