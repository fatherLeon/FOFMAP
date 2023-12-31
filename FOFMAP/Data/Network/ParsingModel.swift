//
//  ParsingModel.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/01.
//

import UIKit

struct ParsingModel {
    func toJson<T: Decodable>(data: Data, by type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        let parsedData = try decoder.decode(type, from: data)
            
        return parsedData
    }
    
    func toImage(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidData
        }
        
        return image
    }
}
