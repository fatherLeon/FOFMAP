//
//  DetailPlayerUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/17.
//

import Foundation

struct DetailPlayerUseCase: DetailFetchable {
    
    typealias T = [PlayerInfo]
    
    private let offerableUseCase: Offerable
    
    init(offerableUseCase: Offerable = FetchUseCase()) {
        self.offerableUseCase = offerableUseCase
    }
    
    func execute() async throws -> [PlayerInfo] {
        throw NetworkError.httpError
    }
}
