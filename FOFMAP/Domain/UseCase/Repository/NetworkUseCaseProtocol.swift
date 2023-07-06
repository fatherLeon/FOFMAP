//
//  NetworkUseCaseProtocol.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/06.
//

protocol NetworkUseCaseProtocol {
    associatedtype T
    
    func execute() async throws -> T
}
