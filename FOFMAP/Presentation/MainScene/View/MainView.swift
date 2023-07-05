//
//  ContentView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/27.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchView(viewModel: viewModel)
                
                Spacer()
                
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
            }
            .navigationTitle("FOFMAP")
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: $viewModel.isShowingErrorAlert, error: viewModel.error) {
                Button("OK", role: .cancel) { }
            }
        }
        .task {
            await viewModel.receiveMostUsedPlayers()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
