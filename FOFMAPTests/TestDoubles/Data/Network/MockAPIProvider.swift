//
//  MockAPIProvider.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/06.
//

@testable
import FOFMAP
import UIKit
import XCTest

final class MockAPIProvider: Providable {
    static var testingSampleData: (data: Data?, error: Error?) = (nil, nil)
    
    private var calledReceiveDataNum = 0
    private var calledReceiveImageNum = 0
    
    func receiveData<T: Decodable>(url: URL, isCached: Bool, by type: T.Type) async throws -> T {
        self.calledReceiveDataNum += 1
        
        if let error = MockAPIProvider.testingSampleData.error {
            throw error
        }
        
        guard let data = MockAPIProvider.testingSampleData.data else {
            throw NetworkError.invalidData
        }
        
        let parsingData = try ParsingModel().toJson(data: data, by: T.self)
        
        return parsingData
    }
    
    func receiveImage(isCached: Bool, by url: URL) async throws -> UIImage {
        self.calledReceiveImageNum += 1
        
        if let error = MockAPIProvider.testingSampleData.error {
            throw error
        }
        
        guard let data = MockAPIProvider.testingSampleData.data else {
            throw NetworkError.invalidData
        }
        
        let parsingData = try ParsingModel().toImage(data: data)
        
        return parsingData
    }
    
    func testingCalledReceiveDataMethod(expectation: Int) {
        XCTAssertEqual(expectation, self.calledReceiveDataNum)
    }
    
    func testingCalledReceiveImageMethod(expectation: Int) {
        XCTAssertEqual(expectation, self.calledReceiveImageNum)
    }
}
