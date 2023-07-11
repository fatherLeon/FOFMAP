//
//  ContentView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/27.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchView(viewModel: viewModel)
                }
                
                if viewModel.isFetchingPlayers {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    Spacer()
                    PlayerListView(viewModel: viewModel)
                }
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
        MainView(viewModel: MainViewModel())
    }
}

