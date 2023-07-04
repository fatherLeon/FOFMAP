//
//  PickerView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import SwiftUI

enum MatchCategory: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case volta = "볼타"
    case officailRank = "공식경기"
}

struct PickerView: View {
    @State private var selectedMatchCategory: MatchCategory = .officailRank
    
    var body: some View {
        HStack {
            Picker(selectedMatchCategory.rawValue, selection: $selectedMatchCategory) {
                ForEach(MatchCategory.allCases) { match in
                    Text(match.rawValue)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
