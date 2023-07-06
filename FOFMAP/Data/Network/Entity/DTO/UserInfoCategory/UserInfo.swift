//
//  UserInfo.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

struct UserInfo: Decodable {
    let id: String
    let nickname: String
    let level: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "accessId"
        case nickname, level
    }
}
