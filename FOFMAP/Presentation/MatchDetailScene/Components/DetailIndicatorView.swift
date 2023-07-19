//
//  DetailIndicatorView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/19.
//

import SwiftUI

struct Indicator: Hashable {
    let title: String
    let value: Int
    
    init(title: String, value: Double) {
        self.title = title
        self.value = Int(value)
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
                    Text("\(indicator.value)")
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
                          Indicator(title: "어시스트", value: 1)]
        DetailIndicatorView(indicatorMainTitle: "공격지표", indicators: indicators)
    }
}
