//
//  MostUsedPlayerUseCaseTests.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/06.
//

@testable
import FOFMAP
import XCTest

final class MostUsedPlayerUseCaseTests: XCTestCase {

    private var sut: (any DetailFetchable)!
    
    override func setUpWithError() throws {
        sut = MostUsedPlayerUseCase(boundaryUsedPlayerNum: 3,
                                    offerableUseCase: MockFetchUseCase())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_executeMethod_Success() async {
        // given
        let expectationCount = 3
        
        // when
        let result = try! await sut.execute() as! [PlayerInfo]
        
        // then
        XCTAssertEqual(expectationCount, result.count)
    }
}
