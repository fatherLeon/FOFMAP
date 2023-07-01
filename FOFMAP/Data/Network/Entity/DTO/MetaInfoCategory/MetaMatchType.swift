//
//  MetaMatchType.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

typealias MetaMatchType = [MatchType]

struct MatchType: Decodable {
    let matchtype: Int
    let desc: String
}
