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
}
