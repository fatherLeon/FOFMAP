//
//  APIProvider.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import UIKit

struct APIProvider {
    private let networkManager: NetworkManager
    private let cacheManager: CacheStorable
    
    init(session: URLSession = .shared, cacheManager: CacheStorable = CacheManager()) {
        self.networkManager = NetworkManager(session: session)
        self.cacheManager = cacheManager
    }
    
    func receiveData<T: Decodable>(url: URL, by type: T.Type) async throws -> T {
        let request = try generateRequest(by: url)
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
        let request = try generateRequest(by: url)
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
    
    private func generateRequest(by url: URL) throws -> URLRequest {
        var request = URLRequest(url: url)
        
        request.addValue("API 토큰", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
