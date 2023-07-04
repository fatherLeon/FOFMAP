//
//  PlayerItem.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import SwiftUI

struct PlayerItemCell: View {
    var body: some View {
        VStack {
            Image("SamplePlayerImage")
                .frame(width: 150, height: 150, alignment: .center)
            
            HStack {
                Image(systemName: "star.fill")
                Text("선수 이름")
            }
        }
    }
}

struct PlayerItemCell_Previews: PreviewProvider {
    static var previews: some View {
        PlayerItemCell()
    }
}
