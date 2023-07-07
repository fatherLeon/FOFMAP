//
//  MockURLCache.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/04.
//

import Foundation

final class FakeURLCache: URLCache {
    
    private var cacheDirectory: [URLRequest: CachedURLResponse] = [:]
    
    var storedCachedNum: Int {
        return cacheDirectory.count
    }
    
    override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        cacheDirectory[request] = cachedResponse
    }
    
    override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        guard let cacheResponse = cacheDirectory[request] else {
            return nil
        }
        
        return cacheResponse
    }
    
    override func removeCachedResponse(for request: URLRequest) {
        cacheDirectory.removeValue(forKey: request)
    }
    
    override func removeAllCachedResponses() {
        cacheDirectory = [:]
    }
}
