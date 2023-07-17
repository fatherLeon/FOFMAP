//
//  MatchDetailView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/14.
//

import SwiftUI

enum UserPick: String, CaseIterable, Identifiable {
    case user = "유저"
    case enemy = "상대"
    
    var id: Self {
        return self
    }
}

struct MatchDetailView: View {
    
    @ObservedObject var viewModel: MatchDetailViewModel
    
    init(userName: String, matchDesc: MatchDesc) {
        self.viewModel = MatchDetailViewModel(userName: userName, matchDesc: matchDesc)
    }
    
    var body: some View {
        VStack {
            Picker("UserState", selection: $viewModel.pickerSelection) {
                ForEach(UserPick.allCases) { picked in
                    Text(picked.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            ZStack {
                GroundView()

                GeometryReader { geomtery in
                }
            }
        }
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(userName: "", matchDesc: MatchDesc(matchID: "123", matchDate: "123", matchType: 1, matchInfo: []))
    }
}
