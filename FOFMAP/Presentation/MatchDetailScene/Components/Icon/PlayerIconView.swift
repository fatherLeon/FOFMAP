//
//  PlayerIconView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/14.
//

import SwiftUI

struct PlayerIconView: View {
    
    private let player: PlayerInfo
    
    init(player: PlayerInfo) {
        self.player = player
    }
    
    var body: some View {
        GeometryReader { geomtery in
            let maxWidth = geomtery.size.width
            
            VStack {
                ZStack {
                    PlayerImageView(image: player.img, width: maxWidth)
                    
                    PlayerGradeView(spGrade: player.spGrade)
                        .frame(width: maxWidth / 12, height: maxWidth / 22, alignment: .trailing)
                        .offset(x: maxWidth / 14, y: maxWidth / 14)
                }
                
                HStack {
                    Image(uiImage: player.seasonImg)
                        .resizable()
                        .frame(width: maxWidth / 25, height: maxWidth / 25)
                    Text(player.name)
                        .font(.caption2)
                }
            }
        }
        .frame(alignment: .center)
    }
}

struct PlayerIconView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerIconView(player: PlayerInfo(id: 123, name: "123", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(systemName: "person.fill")!, positionId: 20, position: .midfielder))
    }
}
