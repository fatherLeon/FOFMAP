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
        return players.isEmpty
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
        
        let useCase = DetailPlayersUseCase(targetPlayers: userMatchInfo.player)
        
        Task { [weak self] in
            guard let playerInfos = try? await useCase.execute() else { return }
            
            self?.players = playerInfos
            self?.userPlayers = playerInfos
        }
    }
    
    @MainActor
    private func getEnemyPlayerInfo() {
        guard let enemyMatchInfo = matchDesc.matchInfo.first(where: { info in
            return info.nickname.uppercased() != self.userName.uppercased()
        }) else { return }
        
        let useCase = DetailPlayersUseCase(targetPlayers: enemyMatchInfo.player)
        
        Task { [weak self] in
            guard let playerInfos = try? await useCase.execute() else { return }
            
            self?.enemyPlayers = playerInfos
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
