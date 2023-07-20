//
//  RecordDetailCell.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/20.
//

import SwiftUI

struct RecordDetailCell: View {
    
    let matchDesc: MatchDesc
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RecordDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetailCell(matchDesc: MatchDesc(matchID: "123456", matchDate: "2203-12-04T12:01:20", matchType: 50, matchInfo: []))
    }
}
