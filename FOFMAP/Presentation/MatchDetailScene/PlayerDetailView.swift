//
//  PlayerDetailView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/18.
//

import SwiftUI

struct PlayerDetailView: View {
    
    let player: PlayerInfo
    
    var body: some View {
        VStack {
            VStack {
                PlayerImageView(image: player.img, width: 500)
                Text(player.name)
            }
            
            ScrollView {
                
                Spacer()
                
                HStack {
                    VStack {
                        Text("선수 시즌")
                        Spacer()
                        Image(uiImage: player.seasonImg)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("강화 등급")
                        Spacer()
                        PlayerGradeView(spGrade: player.spGrade)
                            .frame(width: 30, height: 20, alignment: .center)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("선수 평점")
                        Spacer()
                        Text("\(Int(player.status["spStatus"] ?? 0))")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("포지션")
                        Spacer()
                        Text(player.positionDescription)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                
                VStack {
                    DetailIndicatorView(indicatorMainTitle: "메인 지표",
                                        indicators: [Indicator(title: "슈팅 수", value: player.status["shoot"] ?? 0),
                                                    Indicator(title: "득점", value: player.status["goal"] ?? 0),
                                                    Indicator(title: "어시스트", value: player.status["assist"] ?? 0)])
                    
//                    DetailIndicatorView(indicatorMainTitle: "패스 지표",
//                                        indicators: ["패스 시도 수": player.status["passTry"] ?? 0,
//                                                     "패스 성공 수": player.status["passSuccess"] ?? 0,
//                                                     "패스 성공 확률": (player.status["passSuccess"] ?? 0) / (player.status["passTry"] ?? 1)])
//                    
//                    DetailIndicatorView(indicatorMainTitle: "드리블 지표",
//                                        indicators: ["드리블 시도 수": player.status["dribbleTry"] ?? 0,
//                                                     "드리블 성공 수": player.status["dribbleSuccess"] ?? 0,
//                                                     "드리블 성공 확률": (player.status["dribbleSuccess"] ?? 0) / (player.status["dribbleTry"] ?? 1)])
//                    
//                    DetailIndicatorView(indicatorMainTitle: "볼 경합 지표",
//                                        indicators: ["볼 소유 시도 수": player.status["ballPossesionTry"] ?? 0,
//                                                     "볼 소유 성공 수": player.status["ballPossesionSuccess"] ?? 0,
//                                                     "공중볼 경합 시도 수": player.status["aerialTry"] ?? 0,
//                                                     "공중볼 경합 성공 수": player.status["aerialSuccess"] ?? 0])
//                    
//                    DetailIndicatorView(indicatorMainTitle: "수비 지표",
//                                        indicators: ["블락 시도 수": player.status["blockTry"] ?? 0,
//                                                     "블락 성공 수": player.status["block"] ?? 0,
//                                                     "태클 시도 수": player.status["tackleTry"] ?? 0,
//                                                     "태클 성공 수": player.status["tackle"] ?? 0])
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
    }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailView(player: PlayerInfo(id: 12345, name: "톰 히튼", spGrade: 7, seasonImg: UIImage(systemName: "list.bullet.rectangle.fill")!, img: UIImage(systemName: "person.fill")!, positionId: 5, position: .goalkeeper, status: [:]))
    }
}
