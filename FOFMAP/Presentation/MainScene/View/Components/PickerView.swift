//
//  PickerView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import SwiftUI

struct PickerView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            Picker(viewModel.matchCategory.rawValue, selection: $viewModel.matchCategory) {
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
        PickerView(viewModel: MainViewModel())
    }
}
