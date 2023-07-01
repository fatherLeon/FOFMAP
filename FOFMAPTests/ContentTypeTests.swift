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

    // MARK: 유저정보 테스트
    func test_checkUserInfoURL() throws {
        // given
        let sut = ContentType.userInfo(nickname: "Chelsea")
        
        let expectation = "https://api.nexon.co.kr/fifaonline4/v1.0/users?nickname=Chelsea"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_checkUserMaxGradeURL() throws {
        // given
        let sut = ContentType.userMaxGrade(id: userId)
        
        let expectation = "https://api.nexon.co.kr/fifaonline4/v1.0/users/27ee6f0418d480e60743174b/maxdivision"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_checkUserMatchesURL_and_overLimitValue100() throws {
        // given
        let sut = ContentType.userMatches(id: userId, matchType: 50, offset: 0, limit: 100)
        let overSut = ContentType.userMatches(id: userId, matchType: 50, offset: 0, limit: 120)
        let expectation = "https://api.nexon.co.kr/fifaonline4/v1.0/users/27ee6f0418d480e60743174b/matches?matchtype=50&offset=0&limit=100"
        
        // when
        let result = sut.url!.absoluteString
        let overLimitSutResult = overSut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
        XCTAssertEqual(expectation, overLimitSutResult)
    }
    
    func test_checkUserTradeHistory_and_overLimitValue100() throws {
        // given
        let sut = ContentType.userTradeHistory(id: userId, tradeType: .buy, offset: 0, limit: 100)
        let overSut = ContentType.userTradeHistory(id: userId, tradeType: .buy, offset: 0, limit: 150)
        let expectation = "https://api.nexon.co.kr/fifaonline4/v1.0/users/27ee6f0418d480e60743174b/markets?tradetype=buy&offset=0&limit=100"
        
        // when
        let result = sut.url!.absoluteString
        let overLimitSutResult = overSut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
        XCTAssertEqual(expectation, overLimitSutResult)
    }
}
