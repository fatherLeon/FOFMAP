//
//  MatchRecordUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Foundation

struct MatchRecordUseCase: DetailFetchable {
    typealias T = [MatchDesc]
    
    func execute() async throws -> [MatchDesc] {
        return []
    }
}
