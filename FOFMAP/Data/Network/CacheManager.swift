//
//  CacheManager.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/02.
//

import Foundation

final class CacheManager: CacheStorable {
    private let urlCache: URLCache
    private let semaphore = DispatchSemaphore(value: 1)
    
    init(urlCache: URLCache = .shared) {
        self.urlCache = urlCache
    }
    
    func storeCache(response: URLResponse, data: Data, in request: URLRequest) {
        semaphore.signal()
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        
        urlCache.storeCachedResponse(cachedResponse, for: request)
        
        semaphore.wait()
    }
    
    func getCachedResponse(for request: URLRequest) -> (Data, URLResponse)? {
        semaphore.signal()
        
        guard let cache = urlCache.cachedResponse(for: request) else {
            return nil
        }
        
        let data = cache.data
        let response = cache.response
        
        semaphore.wait()
        
        return (data, response)
    }
    
    func removeCache(for request: URLRequest) {
        semaphore.signal()
        
        urlCache.removeCachedResponse(for: request)
        
        semaphore.wait()
    }
    
    func removeAllCache() {
        semaphore.signal()
        
        urlCache.removeAllCachedResponses()
        
        semaphore.wait()
    }
}
