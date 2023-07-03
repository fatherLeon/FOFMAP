//
//  CacheStorable.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/03.
//

import Foundation

protocol CacheStorable {
    func storeCache(response: URLResponse, data: Data, in request: URLRequest)
    func getCachedResponse(for request: URLRequest) -> (Data, URLResponse)?
    func removeCache(for request: URLRequest)
    func removeAllCache()
}
