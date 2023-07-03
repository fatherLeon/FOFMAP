//
//  Connectable.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/03.
//

import Foundation

protocol Connectable {
    func request(with urlRequest: URLRequest) async throws -> (Data, URLResponse)
}
