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
    
    static func getPositionCordinate(by positionId: Int, viewFrame: (width: CGFloat, height: CGFloat)) -> (x: Double, y: Double) {
        switch positionId {
        case 0:
            return (viewFrame.width * 0.4, viewFrame.height * 0.85)
        case 1, 5:
            return (viewFrame.width * 0.4, viewFrame.height * 0.7)
        case 3:
            return (viewFrame.width * 0.8, viewFrame.height * 0.7)
        case 4:
            return (viewFrame.width * 0.6, viewFrame.height * 0.7)
        case 6:
            return (viewFrame.width * 0.2, viewFrame.height * 0.7)
        case 7:
            return (0, viewFrame.height * 0.7)
        case 2:
            return (viewFrame.width * 0.8, viewFrame.height * 0.52)
        case 9:
            return (viewFrame.width * 0.6, viewFrame.height * 0.52)
        case 10:
            return (viewFrame.width * 0.4, viewFrame.height * 0.52)
        case 11:
            return (viewFrame.width * 0.2, viewFrame.height * 0.52)
        case 8:
            return (0, viewFrame.height * 0.52)
        case 12:
            return (viewFrame.width * 0.8, viewFrame.height * 0.35)
        case 13:
            return (viewFrame.width * 0.6, viewFrame.height * 0.35)
        case 14:
            return (viewFrame.width * 0.4, viewFrame.height * 0.35)
        case 15:
            return (viewFrame.width * 0.2, viewFrame.height * 0.35)
        case 16:
            return (0, viewFrame.height * 0.35)
        case 23:
            return (viewFrame.width * 0.8, viewFrame.height * 0.17)
        case 17:
            return (viewFrame.width * 0.6, viewFrame.height * 0.17)
        case 18:
            return (viewFrame.width * 0.4, viewFrame.height * 0.17)
        case 19:
            return (viewFrame.width * 0.2, viewFrame.height * 0.17)
        case 27:
            return (0, viewFrame.height * 0.17)
        case 22, 26:
            return (viewFrame.width * 0.15, 0)
        case 21, 25:
            return (viewFrame.width * 0.4, 0)
        case 20, 24:
            return (viewFrame.width * 0.65, 0)
        default:
            return (0, 0)
        }
    }
}
