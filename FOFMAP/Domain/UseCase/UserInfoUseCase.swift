//
//  UserInfoUseCase.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/12.
//

import Foundation

struct UserInfoUseCase: DetailFetchable {
    typealias T = User
    
    private let offerableUseCase: Offerable
    private let nickname: String
    
    init(offerableUseCase: Offerable = FetchUseCase(), nickname: String) {
        self.offerableUseCase = offerableUseCase
        self.nickname = nickname
    }
    
    func execute() async throws -> User {
        let (id, level) = try await offerableUseCase.getUserInfo(by: nickname)
        let userGrades = try await offerableUseCase.getUserBestGrade(accessId: id)
        
        guard let officialGrade = userGrades.first(where: { $0.matchType == 50 }) else {
            throw UserError.noExistUser
        }
        
        let gradeDate = Date.toYearMonthDateString(officialGrade.achievementDate)
        let gradeName = try await offerableUseCase.getMetaDivisionGrade(gradeId: officialGrade.division)
        
        return User(nickname: nickname, id: id, level: level, grade: gradeName, gradeDate: gradeDate, gradeId: officialGrade.division)
    }
}
