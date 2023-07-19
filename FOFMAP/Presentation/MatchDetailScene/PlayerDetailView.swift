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
                PlayerImageView(image: player.img, width: 200)
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
                        Text("포지션")
                        Spacer()
                        Text(player.positionDescription)
                    }
                }
            }
        }
    }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailView(player: PlayerInfo(id: 12345, name: "톰 히튼", spGrade: 7, seasonImg: UIImage(systemName: "list.bullet.rectangle.fill")!, img: UIImage(systemName: "person.fill")!, positionId: 5, position: .goalkeeper, status: [:]))
    }
}
