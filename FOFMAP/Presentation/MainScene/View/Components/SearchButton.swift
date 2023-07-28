//
//  SearchButton.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/28.
//

import SwiftUI

struct SearchButton: View {
    
    private let nickname: String
    private let matchCategory: MatchCategory
    
    init(nickname: String, matchCategory: MatchCategory) {
        self.nickname = nickname
        self.matchCategory = matchCategory
    }
    
    var body: some View {
        NavigationLink {
            DeferView {
                RecordView(nickname: nickname, matchCategory: matchCategory)
            }
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
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton(nickname: "123", matchCategory: .classicMatch)
    }
}
