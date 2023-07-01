//
//  ParsingModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import Foundation

struct ParsingModel {
    func toJson<T: Decodable>(data: Data, by type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        
        do {
            let parsedData = try decoder.decode(type, from: data)
            
            return parsedData
        } catch {
            throw NetworkError.incorrectType
        }
    }
}
