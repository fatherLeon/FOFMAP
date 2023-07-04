//
//  MetaSeasonIds.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

typealias MetaSeasonIds = [SeasonId]

struct SeasonId: Decodable {
    let seasonId: Int
    let className: String
    let seasonImgURL: String
    
    enum CodingKeys: String, CodingKey {
        case seasonId, className
        case seasonImgURL = "seasonImg"
    }
}
