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
            Text(player.positionDescription)
                .lineLimit(1)
                .fontWidth(.expanded)
                .frame(width: 60)
                .font(.callout)
            
            Image(uiImage: player.seasonImg)
            PlayerImageView(image: player.img, width: 200)
            Text(player.name)
                .lineLimit(1)
            
            Spacer()
            
            Text("G : \(Int(player.status["goal"] ?? 0))")
                .font(.caption)
            Text("A : \(Int(player.status["assist"] ?? 0))")
                .font(.caption)
            Text("평점 \(String(format: "%.1f", player.status["spRating"] ?? 0))")
                .font(.caption)
        }
    }
}

struct PlayerCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCell(player: PlayerInfo(id: 123, name: "adfsdfsdfs", spGrade: 5, seasonImg: UIImage(systemName: "list.bullet.rectangle.fill")!, img: UIImage(systemName: "person.fill")!, positionId: 1, position: .goalkeeper))
    }
}
