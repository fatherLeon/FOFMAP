//
//  UserError.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/25.
//

import Foundation

enum UserError: LocalizedError {
    case noExistUser
    case noExistMatchRecord
    case noExistMostUsedPlayers
    
    var errorDescription: String? {
        switch self {
        case .noExistUser:
            return "존재하지 않는 유저입니다."
        case .noExistMatchRecord:
            return "매치기록이 존재하지 않습니다."
        case .noExistMostUsedPlayers:
            return "최신 매치기록이 존재하지 않습니다."
        }
    }
}
