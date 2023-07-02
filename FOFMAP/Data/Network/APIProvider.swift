//
//  APIProvider.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import UIKit

struct APIProvider {
    private let networkManager: NetworkManager
    
    init(session: URLSession = .shared) {
        self.networkManager = NetworkManager(session: session)
    }
    
    private func generateRequest(by url: URL) throws -> URLRequest {
        var request = URLRequest(url: url)
        
        request.addValue("", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func receiveData<T: Decodable>(url: URL, by type: T.Type) async throws -> T {
        let request = try generateRequest(by: url)
        let data = try await networkManager.request(with: request)
        let parsedData = try ParsingModel().toJson(data: data, by: type)
        
        
        return parsedData
    }
    
    func receiveImage(by url: URL) async throws -> UIImage {
        let request = try generateRequest(by: url)
        let data = try await networkManager.request(with: request)
        let image = try ParsingModel().toImage(data: data)
        
        return image
    }
}
