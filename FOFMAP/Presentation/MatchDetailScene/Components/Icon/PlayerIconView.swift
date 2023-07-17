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
                    Image(uiImage: player.img)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: maxWidth / 5, height: maxWidth / 5, alignment: .center)
                    
                    PlayerGradeView(spGrade: player.spGrade)
                        .cornerRadius(maxWidth / 2)
                        .frame(width: maxWidth / 10, height: maxWidth / 20, alignment: .trailing)
                        .offset(x: maxWidth / 14, y: -maxWidth / 14)
                }
                
                Image(uiImage: player.seasonImg)
            }
        }
    }
}

struct PlayerIconView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerIconView(player: PlayerInfo(id: 123, name: "123", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(systemName: "person.fill")!, positionId: 20, position: .midfielder))
    }
}
