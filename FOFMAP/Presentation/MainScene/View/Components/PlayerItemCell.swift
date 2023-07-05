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
            Image(uiImage: playerInfo.img)
                .frame(width: 150, height: 150, alignment: .center)
            
            HStack {
                Image(uiImage: playerInfo.seasonImg)
                Text(playerInfo.name)
            }
        }
    }
}

struct PlayerItemCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerItemCell(playerInfo: PlayerInfo(id: 1234, name: "선수이름", seasonImg: UIImage(systemName: "star.fill")!, img: UIImage(named: "SamplePlayerImage")!))
    }
}
