//
//  RecordCell.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import SwiftUI

struct RecordCell: View {
    
    private var scoreText: String
    private var opponentName: String
    
    init(scoreText: String, opponentName: String) {
        self.scoreText = scoreText
        self.opponentName = opponentName
    }
    
    var body: some View {
        HStack {
            // 날짜
            VStack {
                Text("2023.05.30.")
                Text("16:40")
            }
            .font(.caption)
            
            Spacer()
            
            Text(scoreText)
                .bold()
                .font(.title3)
            
            Spacer()
            
            Text(self.opponentName)
                .font(.subheadline)
                .lineLimit(3)

        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

struct RecordCell_Previews: PreviewProvider {
    static var previews: some View {
        RecordCell(scoreText: "1:2", opponentName: "적 이름")
    }
}
