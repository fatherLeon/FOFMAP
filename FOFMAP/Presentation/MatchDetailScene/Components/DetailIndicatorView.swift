//
//  DetailIndicatorView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/19.
//

import SwiftUI

struct DetailIndicatorView: View {
    
    var indicatorMainTitle: String
    var indicators: [String: Double]
    
    var body: some View {
        let keys = indicators.map { $0.key }
        let values = indicators.map { $0.value }
        
        VStack {
            Text(indicatorMainTitle)
                .font(.title)
                .bold()
            
            ForEach(keys.indices, id: \.self) { index in
                HStack {
                    Text(keys[index])
                    Spacer()
                    Text("\(Int(values[index]))")
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
        DetailIndicatorView(indicatorMainTitle: "공격지표", indicators: ["슈팅 수": 2, "유효슈팅 수" : 3, "어시스트 수": 1])
    }
}
