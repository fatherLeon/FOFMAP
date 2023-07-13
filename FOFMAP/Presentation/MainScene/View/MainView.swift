//
//  ContentView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/27.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 5) {
                    ZStack(alignment: .trailing) {
                        TextField("유저 닉네임 검색", text: $viewModel.userNicknameText)
                            .border(.background)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10))
                            .textFieldStyle(.roundedBorder)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(uiColor: UIColor.label))
                            }
                        
                        if !viewModel.isEnabledInTextView {
                            Button {
                                viewModel.apply(.didTapClearTextButton)
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.medium)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                                    .disabled(viewModel.isEnabledInTextView)
                                    .tint(Color(.systemGray3))
                            }
                        }
                    }
                    
                    if viewModel.isEnabledInTextView {
                        PickerView(matchCategory: viewModel.matchCategory)
                            .tint(.green)
                    }
                    
                    NavigationLink {
                        RecordView(nickname: viewModel.userNicknameText, matchCategory: viewModel.matchCategory)
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("검색")
                        }
                        .font(.title3)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.green)
                        }
                    }
                    .disabled(viewModel.isEnabledInTextView)
                    .bold(viewModel.isEnabledInTextView)
                    .tint(.green)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                Spacer()
                
                if viewModel.isFetchingPlayers {
                    ProgressView()
                    Spacer()
                } else {
                    PlayerListView(mostUsedPlayers: viewModel.mostUsedPlayers)
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

