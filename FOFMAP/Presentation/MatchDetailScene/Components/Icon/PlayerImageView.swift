//
//  PlayerImageView.swift
//  FOFMAP
//
//  Created by 강민수 on 11/13/23.
//

import SwiftUI

struct PlayerImageView: View {
    
    let playerImg: Image
    let width: CGFloat
    
    init(image: UIImage, width: CGFloat) {
        self.playerImg = Image(uiImage: image)
        self.width = width
    }
    
    var body: some View {
        playerImg
            .resizable()
            .frame(width: width / 5, height: width / 5)
    }
}

#Preview {
    PlayerImageView(image: UIImage(named: "person.fill")!, width: 300)
}
