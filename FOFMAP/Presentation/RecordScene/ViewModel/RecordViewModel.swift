//
//  RecordViewModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Combine
import Foundation

@MainActor
final class RecordViewModel: ObservableObject {
    
    private let recordUseCase: any DetailFetchable
    private var cancellables = Set<AnyCancellable>()
    
    @Published var matches: [MatchDesc] = []
    @Published var nickname: String = ""
    @Published var isShowingError: UserError? = nil
    @Published var isErrorShownAlert = false
    
    init(recordUseCase: any DetailFetchable) {
        self.recordUseCase = recordUseCase
        
        binding()
    }
    
    private func binding() {
        $nickname
            .sink(receiveValue: { nickname in
                Task { [weak self] in
                    do {
                        guard let matches = try await self?.recordUseCase.execute() as? [MatchDesc] else {
                            return
                        }
                        
                        self?.matches = matches
                    } catch {
                        self?.isShowingError = error as? UserError
                        self?.isErrorShownAlert = true
                    }
                }
            })
            .store(in: &cancellables)
    }
}
