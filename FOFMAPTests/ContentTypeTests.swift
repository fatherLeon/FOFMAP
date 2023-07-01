//
//  FOFMAPTests.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/01.
//

@testable
import FOFMAP
import XCTest

final class ContentTypeTests: XCTestCase {
    
    private let userId = "27ee6f0418d480e60743174b"
    private var sut: ContentType!

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_checkUserInfoURL() throws {
        // given
        sut = ContentType.userInfo(nickname: "Chelsea")
        
        let expectation = "https://api.nexon.co.kr/fifaonline4/v1.0/users?nickname=Chelsea"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_checkUserMaxGradeURL() throws {
        // given
        sut = ContentType.userMaxGrade(id: userId)
        
        let expectation = "https://api.nexon.co.kr/fifaonline4/v1.0/users/27ee6f0418d480e60743174b/maxdivision"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_checkUserMatchesURL() throws {
        
    }
}
