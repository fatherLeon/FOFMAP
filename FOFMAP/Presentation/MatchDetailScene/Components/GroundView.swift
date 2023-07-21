//
//  StadiumView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/13.
//

import SwiftUI

struct GroundView: View {
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                
                Path { path in
                    path.move(to: CGPoint(x: width * 0.35, y: height))
                    path.addLine(to: CGPoint(x: width * 0.35, y: height - 60))
                    path.addLine(to: CGPoint(x: width * 0.65, y: height - 60))
                    path.addLine(to: CGPoint(x: width * 0.65, y: height))
                    
                    path.move(to: CGPoint(x: width * 0.2, y: height))
                    path.addLine(to: CGPoint(x: width * 0.2, y: height - 120))
                    path.addLine(to: CGPoint(x: width * 0.8, y: height - 120))
                    path.addLine(to: CGPoint(x: width * 0.8, y: height))
                    
                    path.move(to: CGPoint(x: width * 0.35, y: height - 120))
                    path.addQuadCurve(to: CGPoint(x: width * 0.65, y: height - 120),
                                      control: CGPoint(x: width / 2, y: height / 1.3))
                    
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addArc(center: CGPoint(x: width * 0.5, y: 0),
                                radius: 90,
                                startAngle: .degrees(180),
                                endAngle: .degrees(0),
                                clockwise: true)
                    
                }
                .stroke(.white, lineWidth: 5)
            }
        }
        .border(.white, width: 5)
    }
}

struct GroundView_Previews: PreviewProvider {
    static var previews: some View {
        GroundView()
    }
}
