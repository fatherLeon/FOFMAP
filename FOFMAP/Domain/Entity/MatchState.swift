//
//  MatchState.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/11.
//

import Foundation

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
}
