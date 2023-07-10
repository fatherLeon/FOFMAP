//
//  RecordViewModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Foundation

final class RecordViewModel {
    private let recordUseCase: any DetailFetchable
    
    init(recordUseCase: any DetailFetchable) {
        self.recordUseCase = recordUseCase
    }
    
    
}
