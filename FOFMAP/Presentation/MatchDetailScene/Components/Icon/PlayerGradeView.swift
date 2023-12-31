//
//  PlayerGrade.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/14.
//

import SwiftUI

struct PlayerGradeView: View {
    
    private let spGrade: Int
    
    init(spGrade: Int) {
        self.spGrade = spGrade
    }
    
    var body: some View {
        Rectangle()
            .fill(CustomColor.matchPlayerGradeBackgroundColor(by: spGrade))
            .overlay {
                Text("\(spGrade)")
                    .foregroundColor(CustomColor.matchPlayerGradeFontColor(by: spGrade))
            }
    }
}

struct PlayerGradeView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerGradeView(spGrade: 5)
    }
}
