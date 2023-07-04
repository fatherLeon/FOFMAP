//
//  MostUsedPlayerUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import Foundation

final class MostUsedPlayerUseCase {
    private let networkingUseCase = FetchNetworkUseCase()
    
    func execute() {
        Task {
            let matcheIds = try await networkingUseCase.getAllMatches(50, offset: 0, limit: 100, orderBy: .desc)
            
        }
    }
}
