//
//  ContentType.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/28.
//

import Foundation

enum ContentType {
    enum TradeType {
        case buy
        case sell
    }
    enum OrderBy {
        case asc
        case desc
    }
    
    // MARK: 유저정보
    case userInfo(nickname: String)
    case userMaxGrade(id: String)
    case userMatches(id: String, matchType: Int, offset: Int, limit: Int)
    case userTradeHistory(id: String, tradeType: TradeType, offset: Int, limit: Int)
    
    // MARK: 매치정보
    case matchAllRecord(matchType: Int, offset: Int, limit: Int, orderBy: OrderBy)
    case matchDesc(matchId: String)
    
    private var scheme: String {
        return "https"
    }
    
    private var host: String {
        switch self {
        case .userInfo(_), .userMaxGrade(_), .userMatches(_, _, _, _), .userTradeHistory(_, _, _, _), .matchAllRecord(_, _, _, _), .matchDesc(_):
            return "api.nexon.co.kr"
        }
    }
    
    private var path: String {
        let basicPath = "/fifaonline4/v1.0"
        let userInfoBasicPath = basicPath + "/users"
        let matchBasicPath = basicPath + "/matches"
        
        switch self {
        case .userInfo(_):
            return userInfoBasicPath
        case .userMaxGrade(let id):
            return userInfoBasicPath + "/\(id)" + "/maxdivision"
        case .userMatches(let id, _, _, _):
            return userInfoBasicPath + "/\(id)" + "/matches"
        case .userTradeHistory(let id, _, _, _):
            return userInfoBasicPath + "/\(id)" + "/markets"
        case .matchAllRecord(_, _, _, _):
            return matchBasicPath
        case .matchDesc(let matchId):
            return matchBasicPath + "/\(matchId)"
        }
    }
    
    private var querys: [URLQueryItem] {
        var querys: [URLQueryItem] = []
        
        switch self {
        case .userInfo(let nickname):
            let nicknameQuery = URLQueryItem(name: "nickname", value: nickname)
            
            querys.append(nicknameQuery)
        case .userMatches(_, let matchType, let offset, let limit):
            let limitValue = limit > 100 ? 100 : limit
            let matchTypeQuery = URLQueryItem(name: "matchtype", value: "\(matchType)")
            let offsetQuery = URLQueryItem(name: "offset", value: "\(offset)")
            let limitQuery = URLQueryItem(name: "limit", value: "\(limitValue)")
            
            querys = [matchTypeQuery, offsetQuery, limitQuery]
        case .userTradeHistory(_, let tradeType, let offset, let limit):
            let tradeTypeValue = tradeType == .buy ? "buy" : "sell"
            let limitValue = limit > 100 ? 100 : limit
            let tradeTypeQuery = URLQueryItem(name: "tradetype", value: tradeTypeValue)
            let offsetQuery = URLQueryItem(name: "offset", value: "\(offset)")
            let limitQuery = URLQueryItem(name: "limit", value: "\(limitValue)")
            
            querys = [tradeTypeQuery, offsetQuery, limitQuery]
        case .matchAllRecord(let matchType, let offset, let limit, let orderBy):
            let limitValue = limit > 100 ? 100 : limit
            let orderByValue = orderBy == .asc ? "asc" : "desc"
            let matchTypeQuery = URLQueryItem(name: "matchtype", value: "\(matchType)")
            let offsetQuery = URLQueryItem(name: "offset", value: "\(offset)")
            let limitQuery = URLQueryItem(name: "limit", value: "\(limitValue)")
            let orderByQuery = URLQueryItem(name: "orderby", value: orderByValue)
            
            querys = [matchTypeQuery, offsetQuery, limitQuery, orderByQuery]
        default:
            break
        }
        
        return querys
    }
    
    var url: URL? {
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = querys
        
        return components.url
    }
}
