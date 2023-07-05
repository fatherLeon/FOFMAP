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
                    Section("공격수") {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack {
                                ForEach(viewModel.mostUsedPlayers, id: \.id) { player in
                                    PlayerItemCell(playerInfo: player)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
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
