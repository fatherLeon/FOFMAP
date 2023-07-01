//
//  MetaPlayerIds.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

typealias MetaPlayerIds = [PlayerId]

struct PlayerId: Decodable {
    let id: Int
    let name: String
}
