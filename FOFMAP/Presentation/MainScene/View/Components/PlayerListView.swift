//
//  PlayerListView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/07.
//

import SwiftUI

struct PlayerListView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        List {
            ForEach(PlayerSection.allCases) { position in
                Section(position.rawValue) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.mostUsedPlayers, id: \.id) { player in
                                if player.position == position {
                                    PlayerItemCell(playerInfo: player)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .listStyle(.inset)
        .refreshable {
            Task {
                await viewModel.receiveMostUsedPlayers()
            }
        }
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView(viewModel: MainViewModel())
    }
}

