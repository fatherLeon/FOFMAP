//
//  MetaPlayerPositions.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

typealias MetaPlayerPositions = [PositionInfo]

struct PositionInfo: Decodable {
    let spposition: Int
    let desc: String
}
