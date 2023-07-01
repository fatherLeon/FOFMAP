//
//  APIProvider.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

struct APIProvider {
    private let networkManager: NetworkManager
    
    init(session: URLSession = .shared) {
        self.networkManager = NetworkManager(session: session)
    }
    
    private func generateRequest(by contentType: ContentType) throws -> URLRequest {
        guard let url = contentType.url else {
            throw NetworkError.urlError
        }
        
        var request = URLRequest(url: url)
        
        request.addValue("", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func receiveData<T: Decodable>(contentType: ContentType, by type: T.Type) async throws -> T {
        let request = try generateRequest(by: contentType)
        
        let data = try await networkManager.data(with: request)
        let parsedData = try ParsingModel().toJson(data: data, by: type)
        
        
        return parsedData
    }
}
