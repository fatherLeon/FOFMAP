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
    @Published var userNicknameText = ""
    @Published var isEnabledInTextView = false
    
    init() {
        binding()
    }
    
    func apply(_ input: Input) {
        switch input {
        case .didTapClearTextButton:
            self.userNicknameText = ""
        }
    }
    
    private func binding() {
        $userNicknameText
            .sink { [weak self] output in
                let isEnabledValue = output.count == 0 ? true: false
                
                self?.isEnabledInTextView = isEnabledValue
            }
            .store(in: &cancellables)
            
    }
}

