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
    private var userPlayers: [PlayerInfo] = []
    private var enemyPlayers: [PlayerInfo] = []
    
    var isFetching: Bool {
        return userPlayers.isEmpty && enemyPlayers.isEmpty
    }
    
    var players: [PlayerInfo] = []
    
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
            
            let useCase = DetailPlayersUseCase(targetPlayer: player)
            
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
            
            let useCase = DetailPlayersUseCase(targetPlayer: player)
            
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
                    self?.players = self?.enemyPlayers ?? []
                case .user:
                    self?.players = self?.userPlayers ?? []
                }
            }
            .store(in: &cancellables)
    }
}
