//
//  CacheManager.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/02.
//

import Foundation

class CacheManager {
    private let urlCache = URLCache(memoryCapacity: 0,
                                    diskCapacity: 100 * 1024 * 1024)
    
    func storeCache(response: URLResponse, data: Data, in request: URLRequest) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        
        urlCache.storeCachedResponse(cachedResponse, for: request)
    }
}
