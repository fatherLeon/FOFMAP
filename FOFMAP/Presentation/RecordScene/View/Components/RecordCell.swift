//
//  RecordCell.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import SwiftUI

struct RecordCell: View {
    
    private let nickname: String
    private let matchDesc: MatchDesc
    
    @State var isClicked: Bool = false
    
    init(nickname: String, matchDesc: MatchDesc) {
        self.nickname = nickname
        self.matchDesc = matchDesc
    }
    
    var body: some View {
        VStack {
            NavigationLink {
                RecordDetailView(matchDesc: matchDesc, nickname: self.nickname)
            } label: {
                HStack {
                    Text(opponentUserName)
                        .font(.subheadline)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(scoreText)
                        .font(.title3)
                        .foregroundColor(matchState.backgroundColor)
                        .bold()
                    
                    VStack {
                        Text(matchYearToDayText)
                        Text(matchHourToMinuteText)
                    }
                    .font(.caption)
                    .padding(.leading, 10)
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            }
        }
    }
}

extension RecordCell {
    private var matchState: MatchState {
        return MatchState.getMatchResult(playerGoal: scores.user, opponentGoal: scores.opponent)
    }
    
    private var matchYearToDayText: String {
        return Date.toYearMonthDateString(matchDesc.matchDate)
    }
    
    private var matchHourToMinuteText: String {
        return Date.toHourMinuteString(matchDesc.matchDate)
    }
    
    private var opponentUserName: String {
        var opponentUserName = ""
        
        matchDesc.matchInfo.forEach { info in
            if info.nickname.uppercased() != self.nickname.uppercased() {
                opponentUserName = info.nickname
            }
        }
        
        return opponentUserName
    }
    
    private var scoreText: String {
        return "\(scores.user) : \(scores.opponent)"
    }
    
    private var scores: (user: Int, opponent: Int) {
        var myGoal = 0
        var opponentGoal = 0
        
        matchDesc.matchInfo.forEach { matchInfo in
            if matchInfo.nickname.uppercased() == nickname.uppercased() {
                myGoal = matchInfo.shoot["goalTotal"] ?? 0
            } else {
                opponentGoal = matchInfo.shoot["goalTotal"] ?? 0
            }
        }
        
        return (myGoal, opponentGoal)
    }
}

struct RecordCell_Previews: PreviewProvider {
    static var previews: some View {
        RecordCell(nickname: "abc", matchDesc: MatchDesc(matchID: "123456", matchDate: "2203-12-04T12:01:20", matchType: 50, matchInfo: []))
    }
}
