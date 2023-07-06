//
//  FetchNetworkUseCaseTests.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/06.
//

@testable
import FOFMAP
import XCTest

final class FetchNetworkUseCaseTests: XCTestCase {
    
    private var sut: FetchNetworkUseCase!
    private var mockProvider: MockAPIProvider!

    override func setUpWithError() throws {
        mockProvider = MockAPIProvider()
        sut = FetchNetworkUseCase(provider: mockProvider)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockProvider = nil
    }

    func test_getUserInfoMethod_SuccessCase() async {
        // given
        MockAPIProvider.testingSampleData = (SampleData.userInfo, nil)
        
        let calledExpectation = 1
        let expectationUserId = "68bb3f88b9b7e862a2639a9d"
        let expectationLevel = 60
        
        // when
        let (resultId, resultLevel) = try! await sut.getUserInfo(by: "민수쨔응")
        
        // then
        XCTAssertEqual(expectationUserId, resultId)
        XCTAssertEqual(expectationLevel, resultLevel)
        
        mockProvider.testingCalledReceiveDataMethod(expectation: calledExpectation)
    }
    
    func test_getUserInfoMethod_FailureCase() async {
        // given
        MockAPIProvider.testingSampleData = (nil, NetworkError.responseError(statusCode: 403))
        
        let calledExpectation = 1
        let expectationError = NetworkError.responseError(statusCode: 403)
        
        // when
        // then
        do {
            _ = try await sut.getUserInfo(by: "민수쨔응")
            XCTFail("This case must be failed")
        } catch {
            XCTAssertEqual(expectationError, error as! NetworkError)
            mockProvider.testingCalledReceiveDataMethod(expectation: calledExpectation)
        }
    }
    
    func test_getAllMatchesMethod_SuccessCase() async {
        // given
        
        
        // when
        
        
        // then
        
    }
}
