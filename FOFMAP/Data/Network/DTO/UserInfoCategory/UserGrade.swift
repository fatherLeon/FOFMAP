//
//  UserGrade.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

/*
 [
     {
         "matchType": 50,
         "division": 2300,
         "achievementDate": "2023-02-18T13:57:31"
     },
     {
         "matchType": 52,
         "division": 2500,
         "achievementDate": "2023-02-10T22:24:53"
     }
 ]
 */

typealias UserGrade = [Grade]

struct Grade: Decodable {
    let matchType: Int
    let division: Int
    let achievementDate: String
}
