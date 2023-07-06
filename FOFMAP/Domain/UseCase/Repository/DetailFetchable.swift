//
//  NetworkUseCaseProtocol.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/06.
//

protocol DetailFetchable {
    associatedtype T
    
    func execute() async throws -> T
}
