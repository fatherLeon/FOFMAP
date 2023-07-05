//
//  PlayerSection.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/05.
//

import Foundation

enum PlayerSection: String, Hashable, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case striker = "공격수"
    case midfielder = "미드필더"
    case defender = "수비수"
    case goalkeeper = "골키퍼"
    
    static func getPosition(by positionId: Int) -> Self? {
        switch positionId {
        case 0:
            return goalkeeper
        case 1...8:
            return defender
        case 9...18:
            return midfielder
        case 20...27:
            return striker
        default:
            return nil
        }
    }
}
