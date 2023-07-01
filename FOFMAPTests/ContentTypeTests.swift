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
    private let playerSpid = 100000250
    private let playerPid = 250

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
    
    // MARK: 매치정보 테스트
    func test_checkMatchAllRecordURL_and_overLimitValue100() throws {
        // given
        let sut = ContentType.matchAllRecord(matchType: 50, offset: 0, limit: 100, orderBy: .asc)
        let overSut = ContentType.matchAllRecord(matchType: 50, offset: 0, limit: 120, orderBy: .asc)
        let expectation = "https://api.nexon.co.kr/fifaonline4/v1.0/matches?matchtype=50&offset=0&limit=100&orderby=asc"
        
        // when
        let result = sut.url!.absoluteString
        let overLimitSutResult = overSut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
        XCTAssertEqual(expectation, overLimitSutResult)
    }
    
    func test_checkMatchDescURL() throws {
        // given
        let matchId = "649ff8b093a520f89079a440"
        let sut = ContentType.matchDesc(matchId: matchId)
        let expectation = "https://api.nexon.co.kr/fifaonline4/v1.0/matches/649ff8b093a520f89079a440"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    // MARK: 메타정보 테스트
    func test_metaMatchTypeURL() throws {
        // given
        let sut = ContentType.metaMatchType
        let expectation = "https://static.api.nexon.co.kr/fifaonline4/latest/matchtype.json"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_metaPlayerIdURL() throws {
        // given
        let sut = ContentType.metaPlayerId
        let expectation = "https://static.api.nexon.co.kr/fifaonline4/latest/spid.json"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_metaSeasonIdURL() throws {
        // given
        let sut = ContentType.metaSeasonId
        let expectation = "https://static.api.nexon.co.kr/fifaonline4/latest/seasonid.json"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_metaPositionURL() throws {
        // given
        let sut = ContentType.metaPosition
        let expectation = "https://static.api.nexon.co.kr/fifaonline4/latest/spposition.json"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_metaGradeURL() throws {
        // given
        let sut = ContentType.metaGrade
        let expectation = "https://static.api.nexon.co.kr/fifaonline4/latest/division.json"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_metaVoltaGrade() throws {
        // given
        let sut = ContentType.metaVoltaGrade
        let expectation = "https://static.api.nexon.co.kr/fifaonline4/latest/division_volta.json"
        
        // when
        let result = sut.url!.absoluteString
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_metaPlayerActionshotImage() throws {
        // given
        let spidSut = ContentType.metaPlayerActionshotImageBySpid(spid: playerSpid)
        let pidSut = ContentType.metaPlayerActionshotImageByPid(pid: playerPid)
        let spidExpectation = "https://fo4.dn.nexoncdn.co.kr/live/externalAssets/common/playersAction/p100000250.png"
        let pidExpectation = "https://fo4.dn.nexoncdn.co.kr/live/externalAssets/common/playersAction/p250.png"
        
        // when
        let spidResult = spidSut.url!.absoluteString
        let pidResult = pidSut.url!.absoluteString
        
        // then
        XCTAssertEqual(spidExpectation, spidResult)
        XCTAssertEqual(pidExpectation, pidResult)
    }
    
    func test_metaPlayerImage() throws {
        // given
        let spidSut = ContentType.metaPlayerImageBySpid(spid: playerSpid)
        let pidSut = ContentType.metaPlayerImageByPid(pid: playerPid)
        let spidExpectation = "https://fo4.dn.nexoncdn.co.kr/live/externalAssets/common/players/p100000250.png"
        let pidExpectation = "https://fo4.dn.nexoncdn.co.kr/live/externalAssets/common/players/p250.png"
        
        // when
        let spidResult = spidSut.url!.absoluteString
        let pidResult = pidSut.url!.absoluteString
        
        // then
        XCTAssertEqual(spidExpectation, spidResult)
        XCTAssertEqual(pidExpectation, pidResult)
    }
}
