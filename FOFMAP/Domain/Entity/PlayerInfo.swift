//
//  PlayerInfo.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import UIKit

struct PlayerInfo: Identifiable {
    let id: Int
    let name: String
    var spGrade: Int = 0
    let seasonImg: UIImage
    let img: UIImage
    let positionId: Int
    let position: PlayerSection
    var status: [String: Double] = [:]
    
    var positionDescription: String {
        switch self.positionId {
        case 0:
            return "GK"
        case 1, 5:
            return "CB"
        case 2:
            return "RWB"
        case 3:
            return "RB"
        case 4:
            return "RCB"
        case 6:
            return "LCB"
        case 7:
            return "LB"
        case 8:
            return "LWB"
        case 9:
            return "RDM"
        case 10:
            return "CDM"
        case 11:
            return "LDM"
        case 12:
            return "RM"
        case 13:
            return "RCM"
        case 14:
            return "CM"
        case 15:
            return "LCM"
        case 16:
            return "LM"
        case 17:
            return "RAM"
        case 18:
            return "CAM"
        case 19:
            return "LAM"
        case 20:
            return "RF"
        case 21:
            return "CF"
        case 22:
            return "LF"
        case 23:
            return "RW"
        case 24:
            return "RS"
        case 25:
            return "ST"
        case 26:
            return "LS"
        case 27:
            return "LW"
        default:
            return "포지션 정보 없음"
        }
    }
}
