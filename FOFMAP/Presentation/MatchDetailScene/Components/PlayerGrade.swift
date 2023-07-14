//
//  PlayerGrade.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/14.
//

import SwiftUI

struct PlayerGrade: View {
    
    private let spGrade: Int
    
    init(spGrade: Int) {
        self.spGrade = spGrade
    }
    
    var body: some View {
        Rectangle()
    }
}

struct PlayerGrade_Previews: PreviewProvider {
    static var previews: some View {
        PlayerGrade(spGrade: 5)
    }
}
