//
//  MockCacheManager.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/03.
//

@testable
import FOFMAP
import Foundation

final class MockCacheManager: CacheStorable {
    private var cacheMap: [URLRequest : (Data, URLResponse)] = [:]
    
    func storeCache(response: URLResponse, data: Data, in request: URLRequest) {
        cacheMap[request] = (data, response)
    }
    
    func getCachedResponse(for request: URLRequest) -> (Data, URLResponse)? {
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
}
