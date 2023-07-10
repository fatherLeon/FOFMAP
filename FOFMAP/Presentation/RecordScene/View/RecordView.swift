//
//  RecordView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/07.
//

import SwiftUI

struct RecordView: View {
    
    @ObservedObject var viewModel: RecordViewModel
    
    init(nickname: String, matchCategory: MatchCategory) {
        let useCase = UserMatchRecordUseCase(nickname: nickname, matchType: matchCategory)
        self.viewModel = RecordViewModel(recordUseCase: useCase)
        self.viewModel.nickname = nickname
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink {
                        // 상세보기
                    } label: {
                        RecordCell()
                    }
                }
            }
            .navigationTitle(viewModel.nickname)
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(nickname: "abc", matchCategory: .classicMatch)
    }
}
