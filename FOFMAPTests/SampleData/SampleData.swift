//
//  StubJsonData.swift
//  FOFMAPTests
//
//  Created by 강민수 on 2023/07/02.
//

import UIKit

struct SampleData {
    static let userInfo = """
    {
        "accessId": "68bb3f88b9b7e862a2639a9d",
        "nickname": "민수쨔응",
        "level": 60
    }
    """.data(using: .utf8)!
    
    static let matchIds = """
    [
            "5d25fa0fea00678d61010bd7",
            "5d25fa336325f381bc55fad5",
            "5d25fa380758fe690757bd81",
            "5d25fa3c13a97367e6e4ae6e"
    ]
    """.data(using: .utf8)!
    
    static let userTradeHistoryData = """
    [
         {
             "tradeDate": "2023-02-19T12:05:23",
             "saleSn": "63f191f21fe6bb1531970ac4",
             "spid": 259208574,
             "grade": 1,
             "value": 2700000000
         },
         {
             "tradeDate": "2023-02-19T12:05:07",
             "saleSn": "63f191e07cca70dbc97ceb7e",
             "spid": 259252371,
             "grade": 1,
             "value": 2710000000
         }
    ]
    """.data(using: .utf8)!
    
    static let imageData = UIImage(named: "SampleImage")!.pngData()!
}
