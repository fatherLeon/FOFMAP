//
//  MainViewModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import SwiftUI
import Combine
import Foundation

final class MainViewModel: ObservableObject {
    enum Input {
        case didTapClearTextButton
    }
    
    private var cancellables = Set<AnyCancellable>()
    private var mostUsedPlayerUseCase: any DetailFetchable
    
    var error: UserError? = nil
    
    @Published var userNicknameText = ""
    @Published var isEnabledInTextView = false
    @Published var isShowingErrorAlert = false
    @Published var isFetchingPlayers = true
    @Published var matchCategory: MatchCategory = .officialMatch
    @Published var mostUsedPlayers: [PlayerInfo] = []
    
    @MainActor
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
    
    @MainActor
    func receiveMostUsedPlayers() async {
        mostUsedPlayers = []
        isFetchingPlayers = true
        isShowingErrorAlert = false
        
        do {
            mostUsedPlayers = try await MostUsedPlayerUseCase().execute()
            isFetchingPlayers = false
        } catch {
            self.error = error as? UserError
            isShowingErrorAlert = true
            isFetchingPlayers = false
        }
    }
    
    @MainActor
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

