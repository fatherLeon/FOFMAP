//
//  PlayerSection.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/05.
//

import Foundation

enum PlayerSection: Hashable {
    case goalkeeper
    case defender
    case midfielder
    case striker
    
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
