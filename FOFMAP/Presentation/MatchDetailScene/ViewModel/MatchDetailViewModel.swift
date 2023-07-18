//
//  MatchDetailViewModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/17.
//

import Combine
import Foundation

final class MatchDetailViewModel: ObservableObject {
    private let matchDesc: MatchDesc
    private let userName: String
    private var cancellables = Set<AnyCancellable>()
    
    var userPlayers: [PlayerInfo] = []
    var enemyPlayers: [PlayerInfo] = []
    var isFetching: Bool {
        return userPlayers.isEmpty && enemyPlayers.isEmpty
    }
    
    @Published var players: [PlayerInfo] = []
    @Published var pickerSelection: UserPick = .user
    
    @MainActor
    init(userName: String, matchDesc: MatchDesc) {
        self.matchDesc = matchDesc
        self.userName = userName
        
        binding()
        getUserPlayerInfo()
        getEnemyPlayerInfo()
    }
    
    func getPickerText(_ picked: UserPick) -> String {
        switch picked {
        case .user:
            return matchDesc.matchInfo.first?.nickname ?? ""
        case .enemy:
            return matchDesc.matchInfo.last?.nickname ?? ""
        }
    }
    
    @MainActor
    private func getUserPlayerInfo() {
        guard let userMatchInfo = matchDesc.matchInfo.first(where: { info in
            return info.nickname.uppercased() == self.userName.uppercased()
        }) else { return }
        
        userMatchInfo.player.forEach { player in
            if player.spPosition == 28 { return }
            
            let useCase = DetailPlayerUseCase(targetPlayer: player)
            
            Task { [weak self] in
                guard let playerInfo = try? await useCase.execute() else { return }
                
                self?.userPlayers.append(playerInfo)
                self?.players.append(playerInfo)
            }
        }
    }
    
    @MainActor
    private func getEnemyPlayerInfo() {
        guard let enemyMatchInfo = matchDesc.matchInfo.first(where: { info in
            return info.nickname.uppercased() != self.userName.uppercased()
        }) else { return }
        
        enemyMatchInfo.player.forEach { player in
            if player.spPosition == 28 { return }
            
            let useCase = DetailPlayerUseCase(targetPlayer: player)
            
            Task { [weak self] in
                guard let playerInfo = try? await useCase.execute() else { return }
                
                self?.enemyPlayers.append(playerInfo)
            }
        }
    }
    
    private func binding() {
        $pickerSelection
            .sink { [weak self] userPick in
                switch userPick {
                case .enemy:
                    let sortedPlayers = self?.enemyPlayers.sorted(by: { $0.status["spRating"] ?? 0 > $1.status["spRating"] ?? 0 }) ?? []
                    
                    self?.players = sortedPlayers
                case .user:
                    let sortedPlayers = self?.userPlayers.sorted(by: { $0.status["spRating"] ?? 0 > $1.status["spRating"] ?? 0 }) ?? []
                    self?.players = sortedPlayers
                }
            }
            .store(in: &cancellables)
    }
}
