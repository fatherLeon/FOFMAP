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
    private var mostUsedPlayerUseCase = MostUsedPlayerUseCase()
    
    var error: NetworkError? = nil
    
    @Published var userNicknameText = ""
    @Published var isEnabledInTextView = false
    @Published var isShowingErrorAlert = false
    @Published var matchCategory: MatchCategory = .officialMatch
    @Published var mostUsedPlayers: [PlayerInfo] = []
    
    init() {
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
        } catch {
            self.error = error as? NetworkError
            self.isShowingErrorAlert = true
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
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.isShowingErrorAlert = false
            }
            .store(in: &cancellables)
    }
}

