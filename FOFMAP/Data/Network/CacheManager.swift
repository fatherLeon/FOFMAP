//
//  CacheManager.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/02.
//

import Foundation

final class CacheManager: CacheStorable {
    private let urlCache: URLCache
    
    init(urlCache: URLCache = URLCache(memoryCapacity: 0, diskCapacity: 100 * 1024 * 1024)) {
        self.urlCache = urlCache
    }
    
    func storeCache(response: URLResponse, data: Data, in request: URLRequest) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        
        urlCache.storeCachedResponse(cachedResponse, for: request)
    }
    
    func getCachedResponse(for request: URLRequest) -> (Data, URLResponse)? {
        guard let cache = urlCache.cachedResponse(for: request) else {
            return nil
        }
        
        let data = cache.data
        let response = cache.response
        
        return (data, response)
    }
    
    func removeCache(for request: URLRequest) {
        urlCache.removeCachedResponse(for: request)
    }
    
    func removeAllCache() {
        urlCache.removeAllCachedResponses()
    }
}
