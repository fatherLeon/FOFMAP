//
//  PickerView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import SwiftUI

struct PickerView: View {
    @State private var selectedMatchCategory: MatchCategory = .officialMatch
    
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
