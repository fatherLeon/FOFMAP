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
    
    private var matchDesc: MatchDesc?
    @State var pick = UserPick.user
    
    var body: some View {
        VStack {
            Picker("UserState", selection: $pick) {
                ForEach(UserPick.allCases) { picked in
                    Text(picked.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            ZStack {
                GroundView()
                
                GeometryReader { geomtery in
                    let maxWidth = geomtery.size.width
                    let maxHeight = geomtery.size.height
                    
                    PlayerIconView()
                        .offset(x: maxWidth / 12, y: 0)
                    PlayerIconView()
                        .offset(x: maxWidth / 2.7, y: 0)
                    PlayerIconView()
                        .offset(x: maxWidth / 1.5, y: 0)
                }
            }
        }
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView()
    }
}
