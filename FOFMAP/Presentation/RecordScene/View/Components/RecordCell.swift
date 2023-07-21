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
                    Text(getOpponentUserName(by: matchDesc))
                        .font(.subheadline)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(getScoreText(by: matchDesc))
                        .font(.title3)
                        .foregroundColor(getMatchState(by: matchDesc).backgroundColor)
                        .bold()
                    
                    VStack {
                        Text(getYearToDayText(by: matchDesc))
                        Text(getHourToMinute(by: matchDesc))
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
    private func getMatchState(by matchDesc: MatchDesc) -> MatchState {
        let (userGoal, opponentGoal) = getScore(by: matchDesc)
        
        return MatchState.getMatchResult(playerGoal: userGoal, opponentGoal: opponentGoal)
    }
    
    private func getYearToDayText(by match: MatchDesc) -> String {
        return Date.toYearMonthDateString(match.matchDate)
    }
    
    private func getHourToMinute(by match: MatchDesc) -> String {
        return Date.toHourMinuteString(match.matchDate)
    }
    
    private func getOpponentUserName(by match: MatchDesc) -> String {
        var opponentUserName = ""
        
        match.matchInfo.forEach { info in
            if info.nickname.uppercased() != self.nickname.uppercased() {
                opponentUserName = info.nickname
            }
        }
        
        return opponentUserName
    }
    
    private func getScoreText(by match: MatchDesc) -> String {
        let (myGoal, opponentGoal) = getScore(by: match)
        
        return "\(myGoal) : \(opponentGoal)"
    }
    
    private func getScore(by match: MatchDesc) -> (user: Int, oppponent: Int) {
        var myGoal = 0
        var opponentGoal = 0
        
        match.matchInfo.forEach { matchInfo in
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
