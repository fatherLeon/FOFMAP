//
//  MetaDivisions.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

typealias MetaGrades = [Grade]

struct Grade: Decodable {
    let divisionId: Int
    let divisionName: String
}
