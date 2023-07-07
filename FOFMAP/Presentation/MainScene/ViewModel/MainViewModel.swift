//
//  MainViewModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import SwiftUI
import Combine
import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    enum Input {
        case didTapClearTextButton
    }
    
    private var cancellables = Set<AnyCancellable>()
    private var mostUsedPlayerUseCase: any DetailFetchable
    
    var error: NetworkError? = nil
    
    @Published var userNicknameText = ""
    @Published var isEnabledInTextView = false
    @Published var isShowingErrorAlert = false
    @Published var isFetchingPlayers = true
    @Published var matchCategory: MatchCategory = .officialMatch
    @Published var mostUsedPlayers: [PlayerInfo] = []
    
    init(mostUsedPlayerUseCase: any DetailFetchable = MostUsedPlayerUseCase()) {
        self.mostUsedPlayerUseCase = mostUsedPlayerUseCase
        binding()
    }
    
    func apply(_ input: Input) {
        switch input {
        case .didTapClearTextButton:
            self.userNicknameText = ""
        }
    }
    
    func receiveMostUsedPlayers() async {
        do {
            self.mostUsedPlayers = try await MostUsedPlayerUseCase().execute()
            self.isFetchingPlayers = false
        } catch {
            self.error = error as? NetworkError
            self.isShowingErrorAlert = true
            self.isFetchingPlayers = false
        }
    }
    
    private func binding() {
        $userNicknameText
            .sink { [weak self] output in
                let isEnabledValue = output.count == 0 ? true: false
                
                self?.isEnabledInTextView = isEnabledValue
            }
            .store(in: &cancellables)
        
        $mostUsedPlayers
            .sink { [weak self] _ in
                self?.isShowingErrorAlert = false
            }
            .store(in: &cancellables)
    }
}

