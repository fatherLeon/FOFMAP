//
//  ComparisonBar.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/21.
//

import SwiftUI

struct ComparisonBar: View {
    
    private let title: String
    private let userValue: Double
    private let opponentValue: Double
    private let isPercentage: Bool
    private let isInterger: Bool
    private let userColor: Color
    private let opponentColor: Color
    
    init(title: String, userValue: Double, opponentValue: Double, isPercentage: Bool, isInterger: Bool, userColor: Color = .red, opponentColor: Color = .blue) {
        self.title = title
        self.isPercentage = isPercentage
        self.isInterger = isInterger
        self.userColor = userColor
        self.opponentColor = opponentColor
        
        if userValue.isNaN {
            self.userValue = 0
        } else {
            self.userValue = userValue
        }
        
        if opponentValue.isNaN {
            self.opponentValue = 0
        } else {
            self.opponentValue = opponentValue
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let maxWidth = geometry.size.width
            
            ZStack {
                VStack {
                    HStack {
                        Text(userValueText)
                        Spacer()
                        Text(title)
                        Spacer()
                        Text(opponentValueText)
                    }
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(userColor)
                            .frame(width: maxWidth * userValueRatio, height: 7)
                        
                        Rectangle()
                            .fill(opponentColor)
                            .frame(width: maxWidth * opponentValueRatio, height: 7)
                    }
                }
            }
            .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
        }
    }
}

extension ComparisonBar {
    private var userValueRatio: Double {
        return (userValue / (userValue + opponentValue))
    }
    
    private var opponentValueRatio: Double {
        return (opponentValue / (userValue + opponentValue))
    }
    
    private var userValueText: String {
        if isPercentage && isInterger {
            return String(format: "%1.f", userValue) + "%"
        }
        
        if isPercentage {
            return String(format: "%1.f", userValue * 100) + "%"
        }
        
        if isInterger {
            return "\(Int(userValue))"
        }
        
        return String(format: "%.1f", userValue)
    }
    
    private var opponentValueText: String {
        if isPercentage && isInterger {
            return String(format: "%1.f", opponentValue) + "%"
        }
        
        if isPercentage {
            return String(format: "%1.f", opponentValue * 100) + "%"
        }
        
        if isInterger {
            return "\(Int(opponentValue))"
        }
        
        return String(format: "%.1f", opponentValue)
    }
}

struct ComparisonBar_Previews: PreviewProvider {
    static var previews: some View {
        ComparisonBar(title: "경기점유율", userValue: 64, opponentValue: 36, isPercentage: true, isInterger: true)
    }
}
