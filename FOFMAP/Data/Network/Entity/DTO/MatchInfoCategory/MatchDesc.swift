//
//  MatchDesc.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

// MARK: - Welcome
struct MatchDesc: Codable {
    let matchID, matchDate: String
    let matchType: Int
    let matchInfo: [MatchInfo]

    enum CodingKeys: String, CodingKey {
        case matchID = "matchId"
        case matchDate, matchType, matchInfo
    }
}

struct MatchInfo: Codable {
    let accessID, nickname: String
    let matchDetail: MatchDetail
    let shoot: [String: Int]
    let shootDetail: [ShootDetail]
    let pass: [String: Int]
    let defence: Defence
    let player: [Player]

    enum CodingKeys: String, CodingKey {
        case accessID = "accessId"
        case nickname, matchDetail, shoot, shootDetail, pass, defence, player
    }
}

struct Defence: Codable {
    let blockTry, blockSuccess, tackleTry, tackleSuccess: Int
}

struct MatchDetail: Codable {
    let seasonID: Int
    let matchResult: String
    let matchEndType, systemPause, foul, injury: Int
    let redCards, yellowCards, dribble, cornerKick: Int
    let possession, offsideCount: Int
    let averageRating: Double
    let controller: String

    enum CodingKeys: String, CodingKey {
        case seasonID = "seasonId"
        case matchResult, matchEndType, systemPause, foul, injury, redCards, yellowCards, dribble, cornerKick, possession, offsideCount, averageRating, controller
    }
}

struct Player: Codable {
    let spID, spPosition, spGrade: Int
    let status: [String: Double]

    enum CodingKeys: String, CodingKey {
        case spID = "spId"
        case spPosition, spGrade, status
    }
}

struct ShootDetail: Codable {
    let goalTime: Int
    let x, y: Double
    let type, result, spID, spGrade: Int
    let spLevel: Int
    let spIDType, assist: Bool
    let assistSPID: Int
    let assistX, assistY: Double
    let hitPost, inPenalty: Bool

    enum CodingKeys: String, CodingKey {
        case goalTime, x, y, type, result
        case spID = "spId"
        case spGrade, spLevel
        case spIDType = "spIdType"
        case assist
        case assistSPID = "assistSpId"
        case assistX, assistY, hitPost, inPenalty
    }
}
