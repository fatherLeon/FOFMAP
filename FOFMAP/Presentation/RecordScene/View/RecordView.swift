//
//  RecordView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/07.
//

import SwiftUI

struct RecordView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: RecordViewModel
    
    init(nickname: String, matchCategory: MatchCategory) {
        let recordUseCase = UserMatchRecordUseCase(nickname: nickname, matchType: matchCategory)
        let userInfoUseCase = UserInfoUseCase(nickname: nickname)
        self.viewModel = RecordViewModel(matchType: matchCategory, recordUseCase: recordUseCase, userInfoUseCase: userInfoUseCase)
        self.viewModel.nickname = nickname
    }
    
    var body: some View {
        VStack {
            if viewModel.matches.isEmpty {
                ProgressView()
            } else {
                HeaderView(user: viewModel.user)
                
                List(viewModel.matches) { matchDesc in
                    VStack {
                        RecordCell(nickname: viewModel.nickname, matchDesc: matchDesc)

                        if viewModel.isPossibleFetch && viewModel.isLastItem(matchDesc) {
                            ProgressView()
                                .onAppear {
                                    viewModel.getAdditionalRecordMatches()
                                }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.isErrorShownAlert, error: viewModel.error) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(nickname: "민수쨔응", matchCategory: .officialMatch)
    }
}

