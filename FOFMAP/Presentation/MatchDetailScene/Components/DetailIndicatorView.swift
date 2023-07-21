//
//  DetailIndicatorView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/19.
//

import SwiftUI

struct Indicator: Hashable {
    let title: String
    let value: Double
    let isPercentage: Bool
    
    init(title: String, value: Double, isPercentage: Bool = false) {
        self.title = title
        self.isPercentage = isPercentage
        
        if isPercentage {
            self.value = value.isNaN ? 0 : value
        } else {
            self.value = value
        }
    }
    
    var valueText: String {
        return "\(Int(value))"
    }
}

struct DetailIndicatorView: View {
    
    var indicatorMainTitle: String
    var indicators: [Indicator]
    
    var body: some View {
        
        VStack {
            Text(indicatorMainTitle)
                .font(.title)
                .bold()
            
            ForEach(indicators, id: \.self) { indicator in
                HStack {
                    Text(indicator.title)
                    Spacer()
                    
                    if indicator.isPercentage {
                        PieGraphView(value: indicator.value, color: .red, lineWidth: 10)
                    } else {
                        Text("\(indicator.valueText)")
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            }
        }
        .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
        .background(CustomColor.drawingColor)
        .cornerRadius(12)
    }
}

struct DetailIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        let indicators = [Indicator(title: "슈팅 수", value: 2),
                          Indicator(title: "유효슈팅 수", value: 3),
                          Indicator(title: "어시스트", value: 1),
                          Indicator(title: "뭐시기 퍼센트", value: 0.3, isPercentage: true)]
        DetailIndicatorView(indicatorMainTitle: "공격지표", indicators: indicators)
    }
}
