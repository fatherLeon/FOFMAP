//
//  MatchDetailView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/14.
//

import SwiftUI

enum UserPick: CaseIterable, Identifiable {
    case user
    case enemy
    
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
        if viewModel.isFetching {
            ProgressView()
        } else {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack {
                        GroundView()
                            .frame(minHeight: 720, maxHeight: 1024)
                        
                        GeometryReader { geomtery in
                            ForEach(viewModel.players) { player in
                                let coordinate = PlayerSection.getPositionCordinate(by: player.positionId, viewFrame: (geomtery.size.width, geomtery.size.height))
                                
                                PlayerIconView(player: player)
                                    .frame(width: geomtery.size.width * 0.8)
                                    .offset(x: coordinate.x, y: coordinate.y)
                                    .onTapGesture {
                                        viewModel.pickedPlayer = player
                                    }
                            }
                        }
                    }
                    
                    Picker("UserState", selection: $viewModel.pickerSelection) {
                        ForEach(UserPick.allCases) { picked in
                            Text(viewModel.getPickerText(picked))
                        }
                    }
                    .padding(.top, 20)
                    .pickerStyle(.segmented)
                    
                    ForEach(viewModel.players) { player in
                        PlayerCell(player: player)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .onTapGesture {
                                viewModel.pickedPlayer = player
                            }
                    }
                }
            }
            .popover(item: $viewModel.pickedPlayer) { player in
                PlayerDetailView(player: player)
            }
        }
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(userName: "abc", matchDesc: MatchDesc(matchID: "123", matchDate: "123", matchType: 1, matchInfo: []))
    }
}
