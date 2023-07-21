//
//  PercentageProgressView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/19.
//

import SwiftUI

struct PieGraphView: View {
    
    let value: Double
    let color: Color
    let lineWidth: CGFloat
    let isPercentage: Bool
    let isInterger: Bool
    
    init(value: Double, color: Color, lineWidth: CGFloat, isPercentage: Bool = true, isInterger: Bool = false) {
        self.color = color
        self.lineWidth = lineWidth
        self.isPercentage = isPercentage
        self.isInterger = isInterger
        
        if value.isNaN {
            self.value = 0.0
        } else {
            self.value = value
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.4), lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0, to: value)
                .stroke(color, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
            
            Text(text)
        }
        .frame(width: 75, height: 75)
    }
}

extension PieGraphView {
    var text: String {
        if isPercentage {
            return String(format: "%.1f", value * 100) + "%"
        }
        
        if isInterger {
            return "\(Int(value))"
        }
        
        return String(format: "%.1f", value)
    }
}

struct PieGraphView_Previews: PreviewProvider {
    static var previews: some View {
        PieGraphView(value: 0.2, color: .blue, lineWidth: 10)
    }
}
