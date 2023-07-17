//
//  PlayerIconView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/14.
//

import SwiftUI

struct PlayerIconView: View {
    var body: some View {
        GeometryReader { geomtery in
            let maxWidth = geomtery.size.width
            let maxHeight = geomtery.size.height
            
            VStack {
                ZStack {
                    Image("Sample")
                        .resizable()
                        .frame(width: maxWidth / 5, height: maxWidth / 5, alignment: .center)
                    
                    PlayerGradeView(spGrade: 8)
                        .frame(width: maxWidth / 10, height: maxWidth / 20, alignment: .trailing)
                        .offset(x: maxWidth / 14, y: -maxWidth / 14)
                }
                
                Image(systemName: "star.fill")
            }
        }
    }
}

struct PlayerIconView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerIconView()
    }
}
