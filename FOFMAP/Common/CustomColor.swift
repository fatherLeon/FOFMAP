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
}
