//
//  PlayerItem.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import SwiftUI

struct PlayerItemCell: View {
    let playerInfo: PlayerInfo
    
    var body: some View {
        VStack {
            Image(uiImage: playerInfo.seasonImg)
                .frame(width: 150, height: 150, alignment: .center)
            
            HStack {
                Image(uiImage: playerInfo.img)
                Text("선수 이름")
            }
        }
    }
}

struct PlayerItemCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerItemCell(playerInfo: PlayerInfo(name: "선수이름", seasonImg: UIImage(named: "SamplePlayerImage")!, img: UIImage(systemName: "star.fill")!))
    }
}