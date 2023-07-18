//
//  CustomColor.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/11.
//

import SwiftUI

enum CustomColor {
    static let gradeBackgroundColor = LinearGradient(colors: [CustomColor.mainColor], startPoint: .leading, endPoint: .trailing)
    static let winningColor = Color("WinningBackground")
    static let drawingColor = Color("DrawingBackground")
    static let losingColor = Color("LosingBackground")
    static let mainColor = Color("MainColor")
    static let normalPlayerGrade = Color("NormalPlayerGrade")
    static let bronzePlayerGrade = Color("BronzePlayerGrade")
    static let silverPlayerGrade = Color("SilverPlayerGrade")
    static let goldPlayerGrade = Color("GoldPlayerGrade")
    
    static func matchPlayerGradeBackgroundColor(_ spGrade: Int) -> Color {
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
    
    static func matchPlayerGradeFontColor(_ spGrade: Int) -> Color {
        switch spGrade {
        case 2...10:
            return Color.black
        default:
            return Color.white
        }
    }
}
