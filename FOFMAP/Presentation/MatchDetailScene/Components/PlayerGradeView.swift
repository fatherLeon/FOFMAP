//
//  PlayerGrade.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/14.
//

import SwiftUI

struct PlayerGradeView: View {
    
    private let spGrade: Int
    private var backgroundColor: Color {
        switch spGrade {
        case 2...4:
            return CustomColor.bronzePlayerGrade
        case 5...7:
            return CustomColor.silverPlayerGrade
        case 8...10:
            return CustomColor.goldPlayerGrade
        default:
            return CustomColor.normalPlayerGrade
        }
    }
    private var fontColor: Color {
        switch spGrade {
        case 2...10:
            return Color.black
        default:
            return Color.white
        }
    }
    
    init(spGrade: Int) {
        self.spGrade = spGrade
    }
    
    var body: some View {
        Rectangle()
            .fill(backgroundColor)
            .overlay {
                Text("\(spGrade)")
                    .bold()
                    .foregroundColor(fontColor)
            }
    }
}

struct PlayerGradeView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerGradeView(spGrade: 8)
    }
}
