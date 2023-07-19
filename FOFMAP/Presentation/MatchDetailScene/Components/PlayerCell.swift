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
            Image(uiImage: player.seasonImg)
            PlayerImageView(image: player.img, width: 200)
            
            Text(player.name)
            Text(player.positionDescription)
            
            Spacer()
            
            Text("골 \(Int(player.status["goal"] ?? 0))")
                .font(.caption)
            
            Text("어시스트 \(Int(player.status["assist"] ?? 0))")
                .font(.caption)
            
            Text("평점 \(String(format: "%.1f", player.status["spRating"] ?? 0))")
        }
    }
}

struct PlayerCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCell(player: PlayerInfo(id: 123, name: "adfsdfsdfs", spGrade: 5, seasonImg: UIImage(systemName: "list.bullet.rectangle.fill")!, img: UIImage(systemName: "person.fill")!, positionId: 1, position: .goalkeeper))
    }
}
