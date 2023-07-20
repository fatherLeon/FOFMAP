//
//  PercentageProgressView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/19.
//

import SwiftUI

struct PercentageProgressView: View {
    
    let percentage: Double
    let color: Color
    let lineWidth: CGFloat
    
    init(percentage: Double, color: Color, lineWidth: CGFloat) {
        self.color = color
        self.lineWidth = lineWidth
        
        if percentage.isNaN {
            self.percentage = 0.0
        } else {
            self.percentage = percentage
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.4), lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(color, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
            
            Text(String(format: "%.1f", percentage * 100) + "%")
                .font(.body)
        }
        .frame(width: 75, height: 75)
    }
}

struct PercentageProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PercentageProgressView(percentage: 0.2, color: .blue, lineWidth: 10)
    }
}
