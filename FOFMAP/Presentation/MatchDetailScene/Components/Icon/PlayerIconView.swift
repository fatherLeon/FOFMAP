//
//  PlayerIconView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/14.
//

import SwiftUI

struct PlayerIconView: View {
    var body: some View {
        VStack {
            ZStack {
                Image("Sample")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                
                PlayerGradeView(spGrade: 8)
                    .frame(width: 40, height: 20, alignment: .trailing)
                    .offset(x: 40, y: -40)
            }
            
            HStack {
                Image(systemName: "star.fill")
                Text("선수 이름")
                    .font(.caption)
            }
        }
    }
}

struct PlayerIconView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerIconView()
    }
}
