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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        DetailIndicatorView(indicatorMainTitle: "공격지표", indicators: ["슈팅 수": 2, "유효슈팅 수" : 3, "어시스트 수": 1])
    }
}
