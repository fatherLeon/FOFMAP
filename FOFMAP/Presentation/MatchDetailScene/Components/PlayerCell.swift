//
//  PlayerCell.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/18.
//

import SwiftUI

struct PlayerCell: View {
    
    let player: PlayerInfo
    
    var body: some View {
        HStack {
            PlayerImageView(image: player.img, width: 200)
            
            Text(player.name)
            
            Spacer()
            
            Text("골 \(Int(player.status["goal"] ?? 0))")
            
            Text("어시스트 \(Int(player.status["assist"] ?? 0))")
            
            Text("평점 \(Int(player.status["spRating"] ?? 0))")
        }
    }
}

struct PlayerCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCell(player: PlayerInfo(id: 123, name: "adfsdfsdfs", spGrade: 5, seasonImg: UIImage(systemName: "list.bullet.rectangle.fill")!, img: UIImage(systemName: "person.fill")!, positionId: 1, position: .goalkeeper))
    }
}
