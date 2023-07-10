//
//  MatchRecordUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Foundation

struct UserMatchRecordUseCase: DetailFetchable {
    typealias T = [MatchDesc]
    
    private let offerableUseCase: Offerable
    
    init(offerableUseCase: Offerable = FetchUseCase()) {
        self.offerableUseCase = offerableUseCase
    }
    
    func execute() async throws -> [MatchDesc] {
        return []
    }
}
