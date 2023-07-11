//
//  RecordCell.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import SwiftUI

struct RecordCell: View {
    
    private let yearToDayText: String
    private let hourToMinuteText: String
    private let scoreText: String
    private let opponentName: String
    private let isWinning: MatchState
    
    init(yearToDayText: String, hourToMinuteText: String, scoreInfo: (player: Int, opponent: Int), opponentName: String) {
        self.yearToDayText = yearToDayText
        self.hourToMinuteText = hourToMinuteText
        self.scoreText = "\(scoreInfo.player) : \(scoreInfo.opponent)"
        self.opponentName = opponentName
        self.isWinning = MatchState.getMatchResult(playerGoal: scoreInfo.player,
                                                   opponentGoal: scoreInfo.opponent)
    }
    
    var body: some View {
        HStack {
            Text(self.opponentName)
                .font(.subheadline)
                .lineLimit(1)
            
            Spacer()
            
            Text(scoreText)
                .bold()
                .font(.title3)
            
            VStack {
                Text(yearToDayText)
                Text(hourToMinuteText)
            }
            .font(.caption)
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

struct RecordCell_Previews: PreviewProvider {
    static var previews: some View {
        RecordCell(yearToDayText: "2022.02.12.", hourToMinuteText: "12:03", scoreInfo: (2, 3), opponentName: "적 이름")
        RecordCell(yearToDayText: "2022.02.12.", hourToMinuteText: "12:03", scoreInfo: (3, 4), opponentName: "적 이름ㅁㅇㄹㅁㅇㄹㅁㅇㅎㅁ")
    }
}
