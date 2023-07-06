//
//  MockAPIProvider.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/06.
//

@testable
import FOFMAP
import UIKit

struct MockAPIProvider: Providable {
    static var testingSampleData: (data: Data?, error: Error?) = (nil, nil)
    
    func receiveData<T>(url: URL, by type: T.Type) async throws -> T where T : Decodable {
        if let error = MockAPIProvider.testingSampleData.error {
            throw error
        }
        
        guard let data = MockAPIProvider.testingSampleData.data else {
            throw NetworkError.invalidData
        }
        
        let parsingData = try ParsingModel().toJson(data: data, by: T.self)
        
        return parsingData
    }
    
    func receiveImage(by url: URL) async throws -> UIImage {
        if let error = MockAPIProvider.testingSampleData.error {
            throw error
        }
        
        guard let data = MockAPIProvider.testingSampleData.data else {
            throw NetworkError.invalidData
        }
        
        let parsingData = try ParsingModel().toImage(data: data)
        
        return parsingData
    }
}
