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
    
    init(connectable: Connectable = NetworkManager(session: .shared),
         cacheStorable: CacheStorable = CacheManager()) {
        self.networkManager = connectable
        self.cacheManager = cacheStorable
    }
    
    func receiveData<T: Decodable>(url: URL, by type: T.Type) async throws -> T {
        let request = generateRequest(by: url)
        let parsingModel = ParsingModel()

        guard let (data, _) = cacheManager.getCachedResponse(for: request) else {
            let data = try await connectingNetwork(by: request)
            let parsedData = try parsingModel.toJson(data: data, by: type)
            
            return parsedData
        }
        
        let parsedData = try parsingModel.toJson(data: data, by: type)
        
        return parsedData
    }
    
    func receiveImage(by url: URL) async throws -> UIImage {
        let request = generateRequest(by: url)
        let parsingModel = ParsingModel()
        
        guard let (data, _) = cacheManager.getCachedResponse(for: request) else {
            let data = try await connectingNetwork(by: request)
            let image = try parsingModel.toImage(data: data)
            
            return image
        }
        
        let image = try parsingModel.toImage(data: data)
        
        return image
    }
    
    private func connectingNetwork(by request: URLRequest) async throws -> Data {
        let (data, response) = try await networkManager.request(with: request)
        
        cacheManager.storeCache(response: response, data: data, in: request)
        
        return data
    }
    
    private func generateRequest(by url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJYLUFwcC1SYXRlLUxpbWl0IjoiNTAwOjEwIiwiYWNjb3VudF9pZCI6Ijg0NjYzOTIwIiwiYXV0aF9pZCI6IjIiLCJleHAiOjE3MDM5OTk0ODQsImlhdCI6MTY4ODQ0NzQ4NCwibmJmIjoxNjg4NDQ3NDg0LCJzZXJ2aWNlX2lkIjoiNDMwMDExNDgxIiwidG9rZW5fdHlwZSI6IkFjY2Vzc1Rva2VuIn0.9Nv8aGcPmi2cySaLulw3ZRKDVI2rCf19bO8k9PrT0Os", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
