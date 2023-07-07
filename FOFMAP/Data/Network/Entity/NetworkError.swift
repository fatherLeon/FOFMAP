//
//  NetworkError.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/28.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case urlError
    case httpError
    case responseError(statusCode: Int)
    case invalidData
    case incorrectType
    
    var errorDescription: String? {
        switch self {
        case .httpError:
            return "네트워크 연결 오류입니다."
        case .incorrectType:
            return "올바르지 않은 데이터 타입입니다."
        case .invalidData:
            return "올바르지 않은 데이터입니다."
        case .responseError(let statusCode):
            return "서버 오류입니다.\(statusCode)"
        case .urlError:
            return "잘못된 형식의 URL입니다."
        }
    }
}
