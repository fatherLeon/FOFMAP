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
                            HStack(spacing: 20) {
                                ForEach(0..<10) { _ in
                                    PlayerItemCell()
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
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
