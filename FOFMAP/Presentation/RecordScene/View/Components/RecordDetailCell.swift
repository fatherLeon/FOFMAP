//
//  RecordDetailCell.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/20.
//

import SwiftUI

struct RecordDetailCell: View {
    
    let matchDesc: MatchDesc
    
    var body: some View {
        VStack {
            HStack {
                let (lhsControllerImage, rhsControllerImage) = getControllerImage()
                
                Text(matchDesc.matchInfo.first?.nickname ?? "")
                Text("\(matchDesc.matchInfo.first?.shoot["goalTotal"] ?? 0)")
                lhsControllerImage
                
                Spacer()
                
                rhsControllerImage
                Text("\(matchDesc.matchInfo.last?.shoot["goalTotal"] ?? 0)")
                Text(matchDesc.matchInfo.last?.nickname ?? "")
            }
            .font(.title3)
            
//            HStack {
//                PercentageProgressView(percentage: matchDesc.matchInfo.first?.matchDetail.averageRating ?? 0,
//                                       color: .red,
//                                       lineWidth: 5,
//                                       isPercentage: false)
//                Spacer()
//                Text("경기 평점")
//                Spacer()
//                PercentageProgressView(percentage: matchDesc.matchInfo.last?.matchDetail.averageRating ?? 0,
//                                       color: .blue,
//                                       lineWidth: 5,
//                                       isPercentage: false)
//            }
            
            HStack {
                PercentageProgressView(percentage: Double (matchDesc.matchInfo.first?.matchDetail.possession ?? 0) / 100,
                                       color: .red,
                                       lineWidth: 5)
                Spacer()
                Text("점유율")
                Spacer()
                PercentageProgressView(percentage: Double(matchDesc.matchInfo.last?.matchDetail.possession ?? 0) / 100,
                                       color: .blue,
                                       lineWidth: 5)
            }
            
            HStack {
                Text("\(matchDesc.matchInfo.first?.shoot["shootTotal"] ?? 0)")
                Spacer()
                Text("총 슈팅")
                Spacer()
                Text("\(matchDesc.matchInfo.last?.shoot["shootTotal"] ?? 0)")
            }
            
            HStack {
                Text("\(matchDesc.matchInfo.first?.shoot["effectiveShootTotal"] ?? 0)")
                Spacer()
                Text("유효슈팅")
                Spacer()
                Text("\(matchDesc.matchInfo.last?.shoot["effectiveShootTotal"] ?? 0)")
            }
            
            HStack {
                PercentageProgressView(percentage: Double(matchDesc.matchInfo.first?.shoot["effectiveShootTotal"] ?? 0) / Double(matchDesc.matchInfo.first?.shoot["shootTotal"] ?? 1),
                                       color: .red,
                                       lineWidth: 5)
                Spacer()
                Text("유효슈팅 비율")
                Spacer()
                PercentageProgressView(percentage: Double(matchDesc.matchInfo.last?.shoot["effectiveShootTotal"] ?? 0) / Double(matchDesc.matchInfo.last?.shoot["shootTotal"] ?? 1),
                                       color: .blue,
                                       lineWidth: 5)
            }
            
            HStack {
                Text("\(matchDesc.matchInfo.first?.pass["passTry"] ?? 0)")
                Spacer()
                Text("패스 시도 수")
                Spacer()
                Text("\(matchDesc.matchInfo.last?.pass["passTry"] ?? 0)")
            }
            
            HStack {
                Text("\(matchDesc.matchInfo.first?.pass["passSuccess"] ?? 0)")
                Spacer()
                Text("패스 성공 수")
                Spacer()
                Text("\(matchDesc.matchInfo.last?.pass["passSuccess"] ?? 0)")
            }
            
            HStack {
                PercentageProgressView(percentage: Double(matchDesc.matchInfo.first?.pass["passSuccess"] ?? 0) / Double(matchDesc.matchInfo.first?.pass["passTry"] ?? 1),
                                       color: .red,
                                       lineWidth: 5)
                Spacer()
                Text("패스 성공 비율")
                Spacer()
                PercentageProgressView(percentage: Double(matchDesc.matchInfo.last?.pass["passSuccess"] ?? 0) / Double(matchDesc.matchInfo.last?.pass["passTry"] ?? 1),
                                       color: .blue,
                                       lineWidth: 5)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
    }
}

extension RecordDetailCell {
    private func getControllerImage() -> (Image, Image) {
        let lhsController = matchDesc.matchInfo.first?.matchDetail.controller == "keyboard" ? Image(systemName: "keyboard.fill") : Image(systemName: "gamecontroller.fill")
        
        let rhsController = matchDesc.matchInfo.last?.matchDetail.controller == "keyboard" ? Image(systemName: "keyboard.fill") : Image(systemName: "gamecontroller.fill")
        
        return (lhsController, rhsController)
    }
}

struct RecordDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        let matchDesc = """
        {
                "matchId": "64b8be35f7a97b711cfa0487",
                "matchDate": "2023-07-20T13:59:40",
                "matchType": 50,
                "matchInfo": [
                        {
                                "accessId": "a651a390313e5d65e0361950",
                                "nickname": "Zl존동명",
                                "matchDetail": {
                                        "seasonId": 202307,
                                        "matchResult": "패",
                                        "matchEndType": 2,
                                        "systemPause": 1,
                                        "foul": 0,
                                        "injury": 0,
                                        "redCards": 0,
                                        "yellowCards": 0,
                                        "dribble": 10,
                                        "cornerKick": 2,
                                        "possession": 32,
                                        "offsideCount": 0,
                                        "averageRating": 3.25556,
                                        "controller": "keyboard"
                                },
                                "shoot": {
                                        "shootTotal": 3,
                                        "effectiveShootTotal": 2,
                                        "shootOutScore": 0,
                                        "goalTotal": 0,
                                        "goalTotalDisplay": 0,
                                        "ownGoal": 0,
                                        "shootHeading": 0,
                                        "goalHeading": 0,
                                        "shootFreekick": 0,
                                        "goalFreekick": 0,
                                        "shootInPenalty": 3,
                                        "goalInPenalty": 0,
                                        "shootOutPenalty": 0,
                                        "goalOutPenalty": 0,
                                        "shootPenaltyKick": 0,
                                        "goalPenaltyKick": 0
                                },
                                "shootDetail": [
                                        {
                                                "goalTime": 749,
                                                "x": 0.8917589783668518,
                                                "y": 0.3852900564670563,
                                                "type": 2,
                                                "result": 1,
                                                "spId": 252200104,
                                                "spGrade": 5,
                                                "spLevel": 5,
                                                "spIdType": true,
                                                "assist": true,
                                                "assistSpId": 279186345,
                                                "assistX": 0.403662383556366,
                                                "assistY": 0.6421405673027039,
                                                "hitPost": false,
                                                "inPenalty": true
                                        },
                                        {
                                                "goalTime": 859,
                                                "x": 0.8553552031517029,
                                                "y": 0.5611183047294617,
                                                "type": 1,
                                                "result": 1,
                                                "spId": 279186345,
                                                "spGrade": 5,
                                                "spLevel": 5,
                                                "spIdType": true,
                                                "assist": true,
                                                "assistSpId": 284183512,
                                                "assistX": 0.9934216141700744,
                                                "assistY": 0.98595118522644,
                                                "hitPost": false,
                                                "inPenalty": true
                                        },
                                        {
                                                "goalTime": 960,
                                                "x": 0.8812592029571533,
                                                "y": 0.5192060470581055,
                                                "type": 6,
                                                "result": 2,
                                                "spId": 252200104,
                                                "spGrade": 5,
                                                "spLevel": 5,
                                                "spIdType": true,
                                                "assist": false,
                                                "assistSpId": -1,
                                                "assistX": 0.5,
                                                "assistY": 0.5,
                                                "hitPost": false,
                                                "inPenalty": true
                                        }
                                ],
                                "pass": {
                                        "passTry": 15,
                                        "passSuccess": 10,
                                        "shortPassTry": 9,
                                        "shortPassSuccess": 6,
                                        "longPassTry": 2,
                                        "longPassSuccess": 2,
                                        "bouncingLobPassTry": 0,
                                        "bouncingLobPassSuccess": 0,
                                        "drivenGroundPassTry": 0,
                                        "drivenGroundPassSuccess": 0,
                                        "throughPassTry": 3,
                                        "throughPassSuccess": 2,
                                        "lobbedThroughPassTry": 1,
                                        "lobbedThroughPassSuccess": 0
                                },
                                "defence": {
                                        "blockTry": 4,
                                        "blockSuccess": 0,
                                        "tackleTry": 7,
                                        "tackleSuccess": 2
                                },
                                "player": [
                                        {
                                                "spId": 260177003,
                                                "spPosition": 13,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 1,
                                                        "defending": 0,
                                                        "passTry": 1,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 1,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 2,
                                                        "ballPossesionSuccess": 1,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 2,
                                                        "block": 0,
                                                        "tackleTry": 2,
                                                        "tackle": 1,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 5.8
                                                }
                                        },
                                        {
                                                "spId": 270181458,
                                                "spPosition": 23,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 1,
                                                        "passSuccess": 1,
                                                        "dribbleTry": 1,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 1,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 5.5
                                                }
                                        },
                                        {
                                                "spId": 284183512,
                                                "spPosition": 8,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 2,
                                                        "passSuccess": 2,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 4.9
                                                }
                                        },
                                        {
                                                "spId": 279186345,
                                                "spPosition": 15,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 1,
                                                        "effectiveShoot": 1,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 1,
                                                        "passSuccess": 1,
                                                        "dribbleTry": 2,
                                                        "dribbleSuccess": 2,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 1,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 5.6
                                                }
                                        },
                                        {
                                                "spId": 273188377,
                                                "spPosition": 2,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 2,
                                                        "passSuccess": 2,
                                                        "dribbleTry": 1,
                                                        "dribbleSuccess": 1,
                                                        "ballPossesionTry": 1,
                                                        "ballPossesionSuccess": 1,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 5.2
                                                }
                                        },
                                        {
                                                "spId": 234189060,
                                                "spPosition": 28,
                                                "spGrade": 2,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 300192366,
                                                "spPosition": 28,
                                                "spGrade": 0,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 252200104,
                                                "spPosition": 27,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 2,
                                                        "effectiveShoot": 1,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 115,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 1,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 4,
                                                        "dribbleSuccess": 3,
                                                        "ballPossesionTry": 4,
                                                        "ballPossesionSuccess": 1,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 5.8
                                                }
                                        },
                                        {
                                                "spId": 250202126,
                                                "spPosition": 25,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 3,
                                                        "passSuccess": 1,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 1,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 1,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 5.4
                                                }
                                        },
                                        {
                                                "spId": 251205923,
                                                "spPosition": 6,
                                                "spGrade": 7,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 1,
                                                        "passSuccess": 1,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 1,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 4.1
                                                }
                                        },
                                        {
                                                "spId": 280220440,
                                                "spPosition": 5,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 1,
                                                        "defending": 0,
                                                        "passTry": 1,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 2,
                                                        "ballPossesionSuccess": 1,
                                                        "aerialTry": 1,
                                                        "aerialSuccess": 1,
                                                        "blockTry": 1,
                                                        "block": 0,
                                                        "tackleTry": 2,
                                                        "tackle": 1,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 6.3
                                                }
                                        },
                                        {
                                                "spId": 300220651,
                                                "spPosition": 28,
                                                "spGrade": 0,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 300222492,
                                                "spPosition": 28,
                                                "spGrade": 0,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 300226271,
                                                "spPosition": 28,
                                                "spGrade": 1,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 321135507,
                                                "spPosition": 28,
                                                "spGrade": 0,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 251150724,
                                                "spPosition": 0,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 1,
                                                        "passTry": 1,
                                                        "passSuccess": 1,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 1,
                                                        "ballPossesionSuccess": 1,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 5.4
                                                }
                                        },
                                        {
                                                "spId": 321153079,
                                                "spPosition": 28,
                                                "spGrade": 0,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 265232488,
                                                "spPosition": 4,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 1,
                                                        "passSuccess": 1,
                                                        "dribbleTry": 1,
                                                        "dribbleSuccess": 1,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 1,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 4.6
                                                }
                                        }
                                ]
                        },
                        {
                                "accessId": "bb7f2c63ba191e41e7738710",
                                "nickname": "사고상사",
                                "matchDetail": {
                                        "seasonId": 202307,
                                        "matchResult": "승",
                                        "matchEndType": 1,
                                        "systemPause": 1,
                                        "foul": 0,
                                        "injury": 0,
                                        "redCards": 0,
                                        "yellowCards": 0,
                                        "dribble": 32,
                                        "cornerKick": 0,
                                        "possession": 68,
                                        "offsideCount": 1,
                                        "averageRating": 4.25,
                                        "controller": "keyboard"
                                },
                                "shoot": {
                                        "shootTotal": 3,
                                        "effectiveShootTotal": 2,
                                        "shootOutScore": 0,
                                        "goalTotal": 2,
                                        "goalTotalDisplay": 3,
                                        "ownGoal": 0,
                                        "shootHeading": 0,
                                        "goalHeading": 0,
                                        "shootFreekick": 0,
                                        "goalFreekick": 0,
                                        "shootInPenalty": 2,
                                        "goalInPenalty": 1,
                                        "shootOutPenalty": 1,
                                        "goalOutPenalty": 1,
                                        "shootPenaltyKick": 0,
                                        "goalPenaltyKick": 0
                                },
                                "shootDetail": [
                                        {
                                                "goalTime": 1552,
                                                "x": 0.7911512851715088,
                                                "y": 0.34751209616661,
                                                "type": 12,
                                                "result": 3,
                                                "spId": 253165153,
                                                "spGrade": 5,
                                                "spLevel": 5,
                                                "spIdType": true,
                                                "assist": true,
                                                "assistSpId": 273239053,
                                                "assistX": 0.7180393934249878,
                                                "assistY": 0.5727123618125916,
                                                "hitPost": false,
                                                "inPenalty": false
                                        },
                                        {
                                                "goalTime": 88,
                                                "x": 0.9434904456138612,
                                                "y": 0.5392804145812988,
                                                "type": 1,
                                                "result": 2,
                                                "spId": 270243812,
                                                "spGrade": 5,
                                                "spLevel": 5,
                                                "spIdType": true,
                                                "assist": false,
                                                "assistSpId": -1,
                                                "assistX": 0.5,
                                                "assistY": 0.5,
                                                "hitPost": false,
                                                "inPenalty": true
                                        },
                                        {
                                                "goalTime": 1951,
                                                "x": 0.9020130038261414,
                                                "y": 0.4205364584922791,
                                                "type": 1,
                                                "result": 3,
                                                "spId": 251182521,
                                                "spGrade": 5,
                                                "spLevel": 5,
                                                "spIdType": true,
                                                "assist": true,
                                                "assistSpId": 273238794,
                                                "assistX": 0.7824056148529053,
                                                "assistY": 0.4312866032123566,
                                                "hitPost": false,
                                                "inPenalty": true
                                        }
                                ],
                                "pass": {
                                        "passTry": 62,
                                        "passSuccess": 59,
                                        "shortPassTry": 44,
                                        "shortPassSuccess": 43,
                                        "longPassTry": 0,
                                        "longPassSuccess": 0,
                                        "bouncingLobPassTry": 0,
                                        "bouncingLobPassSuccess": 0,
                                        "drivenGroundPassTry": 3,
                                        "drivenGroundPassSuccess": 3,
                                        "throughPassTry": 13,
                                        "throughPassSuccess": 12,
                                        "lobbedThroughPassTry": 2,
                                        "lobbedThroughPassSuccess": 1
                                },
                                "defence": {
                                        "blockTry": 4,
                                        "blockSuccess": 1,
                                        "tackleTry": 1,
                                        "tackleSuccess": 1
                                },
                                "player": [
                                        {
                                                "spId": 253165153,
                                                "spPosition": 18,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 1,
                                                        "effectiveShoot": 1,
                                                        "assist": 0,
                                                        "goal": 1,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 8,
                                                        "passSuccess": 8,
                                                        "dribbleTry": 6,
                                                        "dribbleSuccess": 4,
                                                        "ballPossesionTry": 2,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 7.8
                                                }
                                        },
                                        {
                                                "spId": 233167397,
                                                "spPosition": 28,
                                                "spGrade": 3,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 237173521,
                                                "spPosition": 28,
                                                "spGrade": 1,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 321164468,
                                                "spPosition": 28,
                                                "spGrade": 0,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 320179944,
                                                "spPosition": 28,
                                                "spGrade": 0,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 251182521,
                                                "spPosition": 15,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 1,
                                                        "effectiveShoot": 1,
                                                        "assist": 0,
                                                        "goal": 1,
                                                        "dribble": 0,
                                                        "intercept": 1,
                                                        "defending": 0,
                                                        "passTry": 13,
                                                        "passSuccess": 12,
                                                        "dribbleTry": 9,
                                                        "dribbleSuccess": 9,
                                                        "ballPossesionTry": 4,
                                                        "ballPossesionSuccess": 2,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 1,
                                                        "block": 0,
                                                        "tackleTry": 1,
                                                        "tackle": 1,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 7.8
                                                }
                                        },
                                        {
                                                "spId": 321186132,
                                                "spPosition": 28,
                                                "spGrade": 0,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 216191695,
                                                "spPosition": 25,
                                                "spGrade": 8,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 11,
                                                        "passSuccess": 10,
                                                        "dribbleTry": 6,
                                                        "dribbleSuccess": 5,
                                                        "ballPossesionTry": 2,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 6.8
                                                }
                                        },
                                        {
                                                "spId": 234192119,
                                                "spPosition": 0,
                                                "spGrade": 6,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 1,
                                                        "passTry": 1,
                                                        "passSuccess": 1,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 6.8
                                                }
                                        },
                                        {
                                                "spId": 260197445,
                                                "spPosition": 4,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 2,
                                                        "passSuccess": 2,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 1,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 6.3
                                                }
                                        },
                                        {
                                                "spId": 300201153,
                                                "spPosition": 28,
                                                "spGrade": 0,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 511205452,
                                                "spPosition": 6,
                                                "spGrade": 6,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 3,
                                                        "passSuccess": 3,
                                                        "dribbleTry": 1,
                                                        "dribbleSuccess": 1,
                                                        "ballPossesionTry": 1,
                                                        "ballPossesionSuccess": 1,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 1,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 6.4
                                                }
                                        },
                                        {
                                                "spId": 300219809,
                                                "spPosition": 28,
                                                "spGrade": 0,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 0
                                                }
                                        },
                                        {
                                                "spId": 280228618,
                                                "spPosition": 7,
                                                "spGrade": 2,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 0,
                                                        "passSuccess": 0,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 6.3
                                                }
                                        },
                                        {
                                                "spId": 273238794,
                                                "spPosition": 27,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 1,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 4,
                                                        "passSuccess": 4,
                                                        "dribbleTry": 3,
                                                        "dribbleSuccess": 3,
                                                        "ballPossesionTry": 1,
                                                        "ballPossesionSuccess": 1,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 7.4
                                                }
                                        },
                                        {
                                                "spId": 273239053,
                                                "spPosition": 13,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 1,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 1,
                                                        "defending": 0,
                                                        "passTry": 14,
                                                        "passSuccess": 13,
                                                        "dribbleTry": 5,
                                                        "dribbleSuccess": 5,
                                                        "ballPossesionTry": 2,
                                                        "ballPossesionSuccess": 1,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 1,
                                                        "block": 1,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 7.8
                                                }
                                        },
                                        {
                                                "spId": 270243812,
                                                "spPosition": 23,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 1,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 5,
                                                        "passSuccess": 5,
                                                        "dribbleTry": 2,
                                                        "dribbleSuccess": 2,
                                                        "ballPossesionTry": 1,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 6.5
                                                }
                                        },
                                        {
                                                "spId": 280248243,
                                                "spPosition": 3,
                                                "spGrade": 5,
                                                "status": {
                                                        "shoot": 0,
                                                        "effectiveShoot": 0,
                                                        "assist": 0,
                                                        "goal": 0,
                                                        "dribble": 0,
                                                        "intercept": 0,
                                                        "defending": 0,
                                                        "passTry": 1,
                                                        "passSuccess": 1,
                                                        "dribbleTry": 0,
                                                        "dribbleSuccess": 0,
                                                        "ballPossesionTry": 0,
                                                        "ballPossesionSuccess": 0,
                                                        "aerialTry": 0,
                                                        "aerialSuccess": 0,
                                                        "blockTry": 0,
                                                        "block": 0,
                                                        "tackleTry": 0,
                                                        "tackle": 0,
                                                        "yellowCards": 0,
                                                        "redCards": 0,
                                                        "spRating": 6.6
                                                }
                                        }
                                ]
                        }
                ]
        }
        """.data(using: .utf8)
        
        let parsedMatchDesc = try! ParsingModel().toJson(data: matchDesc!, by: MatchDesc.self)
        
        RecordDetailCell(matchDesc: parsedMatchDesc)
    }
}
