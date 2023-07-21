//
//  PieGraphView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/21.
//

import SwiftUI

struct PieGraphView: View {
    
    private let title: String
    private let userValue: Double
    private let opponentValue: Double
    private let userColor: Color
    private let opponentColor: Color
    private let isPercentage: Bool
    private let lineWidth: CGFloat
    private let isIntger: Bool
    
    init(title: String, userValue: Double, opponentValue: Double, userColor: Color, opponentColor: Color, lineWidth: CGFloat, isPercentage: Bool, isInterger: Bool = true) {
        self.title = title
        self.userValue = userValue
        self.opponentValue = opponentValue
        self.userColor = userColor
        self.opponentColor = opponentColor
        self.isPercentage = isPercentage
        self.lineWidth = lineWidth
        self.isIntger = isInterger
    }
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: trimValue)
                .stroke(opponentColor, lineWidth: lineWidth)
                .rotationEffect(.radians(.pi * 1.5))
            
            VStack {
                Text(title)
                    .font(.title)
                    .padding(.bottom, 10)
                
                HStack {
                    Text(userValueText)
                        .foregroundColor(userColor)
                    Text("VS")
                    Text(opponentValueText)
                        .foregroundColor(opponentColor)
                }
                .font(.title3)
            }
            
            Circle()
                .trim(from: trimValue, to: 1.0)
                .stroke(userColor, lineWidth: lineWidth)
                .rotationEffect(.radians(.pi * 1.5))
        }
    }
}

extension PieGraphView {
    private var trimValue: Double {
        return opponentValue / (userValue + opponentValue)
    }
    
    private var userValueText: String {
        if isPercentage {
            return String(format: "%.1f", userValue * 100) + "%"
        }
        
        if isIntger {
            return "\(Int(userValue))"
        }
        
        return String(format: "%.1f", userValue)
    }
    
    private var opponentValueText: String {
        if isPercentage {
            return String(format: "%.1f", opponentValue * 100) + "%"
        }
        
        if isIntger {
            return "\(Int(opponentValue))"
        }
        
        return String(format: "%.1f", opponentValue)
    }
}

struct PieGraphView_Previews: PreviewProvider {
    static var previews: some View {
        PieGraphView(title: "경기 평점", userValue: 6.4, opponentValue: 7.2, userColor: .red, opponentColor: .blue, lineWidth: 15, isPercentage: false, isInterger: false)
    }
}
