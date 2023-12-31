//
//  UserTradeHistory.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

/*
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
 */

typealias UserTradeHistory = [TradeHistory]

struct TradeHistory: Decodable {
    let tradeDate: String
    let saleSn: String
    let spid: Int
    let grade: Int
    let value: Int
}
