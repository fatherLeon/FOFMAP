//
//  MatchDetailViewModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/17.
//

import Foundation

final class MatchDetailViewModel {
    private let matchDesc: MatchDesc
    private let userPlayers: [PlayerInfo] = []
    private let enemyPlayers: [PlayerInfo] = []
    
    init(matchDesc: MatchDesc) {
        self.matchDesc = matchDesc
    }
}
