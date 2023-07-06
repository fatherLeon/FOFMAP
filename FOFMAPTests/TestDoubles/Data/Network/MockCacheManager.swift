//
//  MockCacheManager.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/03.
//

@testable
import FOFMAP
import XCTest
import Foundation

final class MockCacheManager: CacheStorable {
    
    private var cacheMap: [URLRequest : (Data, URLResponse)] = [:]
    private var calledStoreCacheMethodCount = 0
    private var calledGetCachedResponseMethodCount = 0
    
    func storeCache(response: URLResponse, data: Data, in request: URLRequest) {
        self.calledStoreCacheMethodCount += 1
        cacheMap[request] = (data, response)
    }
    
    func getCachedResponse(for request: URLRequest) -> (Data, URLResponse)? {
        self.calledGetCachedResponseMethodCount += 1
        
        guard let (data, response) = cacheMap[request] else {
            return nil
        }
        
        return (data, response)
    }
    
    func removeCache(for request: URLRequest) {
        cacheMap.removeValue(forKey: request)
    }
    
    func removeAllCache() {
        cacheMap = [:]
    }
    
    func testCheckingStoreCache(_ count: Int) {
        XCTAssertEqual(count, calledStoreCacheMethodCount)
    }
    
    func testCheckingGetCachedResponse(_ count: Int) {
        XCTAssertEqual(count, calledGetCachedResponseMethodCount)
    }
}
