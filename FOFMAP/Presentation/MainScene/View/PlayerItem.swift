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
            Image(systemName: "person.fill")
                .frame(width: 200, height: 200, alignment: .center)
            
            HStack {
                Image(systemName: "star.fill")
                Text("선수 이름")
            }
        }
    }
}

struct PlayerItem_Previews: PreviewProvider {
    static var previews: some View {
        PlayerItemCell()
    }
}
