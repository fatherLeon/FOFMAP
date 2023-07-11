//
//  RecordView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/07.
//

import SwiftUI

struct RecordView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: RecordViewModel
    
    init(nickname: String, matchCategory: MatchCategory) {
        let useCase = UserMatchRecordUseCase(nickname: nickname, matchType: matchCategory)
        self.viewModel = RecordViewModel(matchType: matchCategory, recordUseCase: useCase)
        self.viewModel.nickname = nickname
    }
    
    var body: some View {
        VStack {
            
            List(viewModel.matches, id: \.matchID) { matchDesc in
                NavigationLink {
                    Text(matchDesc.matchID)
                } label: {
                    VStack {
                        RecordCell(yearToDayText: viewModel.getYearToDayText(by: matchDesc),
                                   hourToMinuteText: viewModel.getHourToMinute(by: matchDesc),
                                   scoreText: viewModel.getScoreText(by: matchDesc),
                                   opponentName: viewModel.getOpponentUserName(by: matchDesc))
                        
                        if viewModel.isPossibleFetch && viewModel.isLastItem(matchDesc) {
                            ProgressView()
                                .onAppear {
                                    viewModel.getAdditionalRecordMatches()
                                }
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.nickname)
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.isErrorShownAlert, error: viewModel.error) {
            Button(role: .cancel) {
                dismiss()
            } label: {
                Text("OK")
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(nickname: "민수쨔응", matchCategory: .classicMatch)
    }
}

