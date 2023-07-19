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
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.4), lineWidth: 50)
            
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(color, lineWidth: 50)
                .rotationEffect(.degrees(-90))
        }
    }
}

struct PercentageProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PercentageProgressView(percentage: 0.2, color: .blue)
    }
}
