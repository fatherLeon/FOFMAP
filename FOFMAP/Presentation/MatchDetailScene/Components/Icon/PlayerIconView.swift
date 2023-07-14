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
            HStack {
                Spacer()
                PlayerGradeView(spGrade: 5)
                    .frame(width: 50, height: 40, alignment: .trailing)
            }
            Circle()
                .stroke(Color.white, lineWidth: 3)
                .overlay {
                    Image(systemName: "person.fill")
                }
            
            HStack {
                Image(systemName: "star.fill")
                Text("선수 이름")
            }
        }
    }
}

struct PlayerIconView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerIconView()
    }
}
