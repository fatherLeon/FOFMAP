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
            .padding(.top, 20)
            
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
                        Text("\(String(format: "%.1f", player.status["spRating"] ?? 0))")
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
                                        indicators: [
                                            Indicator(title: "슈팅 수", value: player.status["shoot"] ?? 0),
                                            Indicator(title: "유효 슈팅 수", value: player.status["effectiveShoot"] ?? 0),
                                                    Indicator(title: "득점", value: player.status["goal"] ?? 0),
                                                    Indicator(title: "어시스트", value: player.status["assist"] ?? 0),
                                            Indicator(title: "유효 슈팅 비율",
                                                      value: (player.status["effectiveShoot"] ?? 0) / (player.status["shoot"] ?? 1),
                                                      isPercentage: true)
                                        ])
                    
                    DetailIndicatorView(indicatorMainTitle: "패스 지표",
                                        indicators: [
                                            Indicator(title: "시도 수", value: player.status["passTry"] ?? 0),
                                                    Indicator(title: "성공 수", value: player.status["passSuccess"] ?? 0),
                                                    Indicator(title: "성공 확률", value: (player.status["passSuccess"] ?? 0) / (player.status["passTry"] ?? 1), isPercentage: true)
                                        ])
                    
                    DetailIndicatorView(indicatorMainTitle: "드리블 지표",
                                        indicators: [
                                            Indicator(title: "시도 수", value: player.status["dribbleTry"] ?? 0),
                                                     Indicator(title: "성공 수", value: player.status["dribbleSuccess"] ?? 0),
                                                    Indicator(title: "성공 확률", value: (player.status["dribbleSuccess"] ?? 0) / (player.status["dribbleTry"] ?? 1), isPercentage: true)
                                        ])
                    
                    DetailIndicatorView(indicatorMainTitle: "볼 경합 지표",
                                        indicators: [
                                            Indicator(title: "볼 소유 시도 수", value: player.status["ballPossesionTry"] ?? 0),
                                                    Indicator(title: "볼 소유 성공 수", value: player.status["ballPossesionSuccess"] ?? 0),
                                                    Indicator(title: "공중볼 경합 시도 수", value: player.status["aerialTry"] ?? 0),
                                                    Indicator(title: "공중볼 경합 성공 수", value: player.status["aerialSuccess"] ?? 0)
                                        ])
                    
                    DetailIndicatorView(indicatorMainTitle: "수비 지표",
                                        indicators: [
                                            Indicator(title: "블락 시도 수", value: player.status["blockTry"] ?? 0),
                                            Indicator(title: "블락 성공 수", value: player.status["block"] ?? 0),
                                            Indicator(title: "태클 시도 수", value: player.status["tackleTry"] ?? 0),
                                            Indicator(title: "태클 성공 수", value: player.status["tackle"] ?? 0)
                                        ])
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
