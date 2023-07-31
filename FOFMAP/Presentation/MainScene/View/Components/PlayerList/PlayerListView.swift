//
//  PlayerListView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/07.
//

import SwiftUI

struct PlayerListView: View {
    
    @State var mostUsedPlayers: [PlayerInfo]
    
    var body: some View {
        List {
            ForEach(PlayerSection.allCases) { position in
                Section(position.rawValue) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(mostUsedPlayers, id: \.id) { player in
                                if player.position == position {
                                    PlayerItemCell(playerInfo: player)
                                }
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.inset)
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView(mostUsedPlayers: MainViewModel().mostUsedPlayers)
    }
}


