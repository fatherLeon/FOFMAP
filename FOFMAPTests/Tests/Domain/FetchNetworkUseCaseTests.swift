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
    
    private var sut: FetchUseCase!
    private var mockProvider: MockAPIProvider!

    override func setUpWithError() throws {
        mockProvider = MockAPIProvider()
        sut = FetchUseCase(provider: mockProvider)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockProvider = nil
    }

    func test_getUserInfoMethod_SuccessCase() async {
        // given
        MockAPIProvider.testingSampleData = (SampleData.userInfo, nil)
        
        let calledDataMethodExpectation = 1
        let calledImageMethodExpectation = 0
        let expectationUserId = "68bb3f88b9b7e862a2639a9d"
        let expectationLevel = 60
        
        // when
        let (resultId, resultLevel) = try! await sut.getUserInfo(by: "민수쨔응")
        
        // then
        XCTAssertEqual(expectationUserId, resultId)
        XCTAssertEqual(expectationLevel, resultLevel)
        
        mockProvider.testingCalledReceiveDataMethod(expectation: calledDataMethodExpectation)
        mockProvider.testingCalledReceiveImageMethod(expectation: calledImageMethodExpectation)
    }
    
    func test_getUserInfoMethod_FailureCase() async {
        // given
        MockAPIProvider.testingSampleData = (nil, NetworkError.responseError(statusCode: 403))
        
        let calledDataMethodExpectation = 1
        let calledImageMethodExpectation = 0
        let expectationError = NetworkError.responseError(statusCode: 403)
        
        // when
        // then
        do {
            _ = try await sut.getUserInfo(by: "민수쨔응")
            XCTFail("This case must be failed")
        } catch {
            XCTAssertEqual(expectationError, error as! NetworkError)
            mockProvider.testingCalledReceiveDataMethod(expectation: calledDataMethodExpectation)
            mockProvider.testingCalledReceiveImageMethod(expectation: calledImageMethodExpectation)
        }
    }
    
    func test_getAllMatchesMethod_SuccessCase() async {
        // given
        MockAPIProvider.testingSampleData = (SampleData.matchIds, nil)
        
        let calledDataMethodExpectation = 1
        let calledImageMethodExpectation = 0
        let expectationResultCount = 4
        let expectationFirstId = "5d25fa0fea00678d61010bd7"
        
        // when
        let result = try! await sut.getAllMatches(50, offset: 0, limit: 100)
        
        // then
        XCTAssertEqual(expectationResultCount, result.count)
        XCTAssertEqual(expectationFirstId, result.first!)
        
        mockProvider.testingCalledReceiveDataMethod(expectation: calledDataMethodExpectation)
        mockProvider.testingCalledReceiveImageMethod(expectation: calledImageMethodExpectation)
    }
    
    func test_getMatchDescAllPlayers_SuccessCase() async {
        // given
        MockAPIProvider.testingSampleData = (SampleData.matchDescData, nil)
        
        let calledDataMethodExpectation = 1
        let calledImageMethodExpectation = 0
        let expectationResultCount = 36
        
        // when
        let result = try! await sut.getMatchDescAllPlayers(matchId: "test")
        
        // then
        XCTAssertEqual(expectationResultCount, result.count)
        
        mockProvider.testingCalledReceiveDataMethod(expectation: calledDataMethodExpectation)
        mockProvider.testingCalledReceiveImageMethod(expectation: calledImageMethodExpectation)
    }
    
    func test_getPlayerActionImage_SuccessCase() async {
        // given
        MockAPIProvider.testingSampleData = (SampleData.imageData, nil)
        
        let calledDataMethodExpectation = 0
        let calledImageMethodExpectation = 1
        let expectationImage = UIImage(data: SampleData.imageData)!
        
        // when
        let resultImage = try! await sut.getPlayerActionImage(by: 102)
        
        // then
        XCTAssertEqual(expectationImage.pngData(), resultImage.pngData())
        
        mockProvider.testingCalledReceiveDataMethod(expectation: calledDataMethodExpectation)
        mockProvider.testingCalledReceiveImageMethod(expectation: calledImageMethodExpectation)
    }
}
