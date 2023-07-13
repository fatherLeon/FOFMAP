//
//  MatchState.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/11.
//

import SwiftUI

enum MatchState {
    case winning
    case losing
    case drawing
    
    static func getMatchResult(playerGoal: Int, opponentGoal: Int) -> Self {
        switch playerGoal - opponentGoal {
        case 0:
            return drawing
        case 1...:
            return winning
        default:
            return losing
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .winning:
            return CustomColor.winningColor
        case .drawing:
            return CustomColor.drawingColor
        case .losing:
            return CustomColor.losingColor
        }
    }
}
