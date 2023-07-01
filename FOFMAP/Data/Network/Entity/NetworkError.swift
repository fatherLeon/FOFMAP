//
//  NetworkError.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/28.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case httpError
    case responseError(statusCode: Int)
    case invalidData
    case incorrectType
}
