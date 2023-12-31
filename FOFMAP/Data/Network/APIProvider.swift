//
//  APIProvider.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import UIKit

struct APIProvider: Providable {
    private let networkManager: Connectable
    private let cacheManager: CacheStorable
    private let parsingModel = ParsingModel()
    
    init(connectable: Connectable = NetworkManager(session: .shared),
         cacheStorable: CacheStorable = CacheManager()) {
        self.networkManager = connectable
        self.cacheManager = cacheStorable
    }
    
    func receiveData<T: Decodable>(url: URL, isCached: Bool, by type: T.Type) async throws -> T {
        let request = generateRequest(by: url)

        guard let (data, _) = cacheManager.getCachedResponse(for: request) else {
            let data = try await connectingNetwork(by: request, isCached: isCached)
            let parsedData = try parsingModel.toJson(data: data, by: type)
            
            return parsedData
        }
        
        let parsedData = try parsingModel.toJson(data: data, by: type)
        
        return parsedData
    }
    
    func receiveImage(isCached: Bool, by url: URL) async throws -> UIImage {
        let request = generateRequest(by: url)
        
        guard let (data, _) = cacheManager.getCachedResponse(for: request) else {
            let data = try await connectingNetwork(by: request, isCached: isCached)
            let image = try parsingModel.toImage(data: data)
            
            return image
        }
        
        let image = try parsingModel.toImage(data: data)
        
        return image
    }
    
    private func connectingNetwork(by request: URLRequest, isCached: Bool) async throws -> Data {
        let (data, response) = try await networkManager.request(with: request)
        
        if isCached {
            cacheManager.storeCache(response: response, data: data, in: request)
        }
        
        return data
    }
    
    private func generateRequest(by url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.addValue(Bundle.nexonAPIKey, forHTTPHeaderField: "Authorization")
        
        return request
    }
}
