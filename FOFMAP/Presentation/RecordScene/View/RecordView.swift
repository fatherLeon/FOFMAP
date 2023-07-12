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
                HeaderView(nickname: viewModel.nickname, level: 400, grade: "챔피언스")
                
                List(viewModel.matches) { matchDesc in
                    NavigationLink {
                        // 매치 세부 뷰
                    } label: {
                        VStack {
                            RecordCell(yearToDayText: viewModel.getYearToDayText(by: matchDesc),
                                       hourToMinuteText: viewModel.getHourToMinute(by: matchDesc),
                                       scoreInfo: viewModel.getScoreText(by: matchDesc),
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
                .listStyle(.plain)
            }
        }
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

