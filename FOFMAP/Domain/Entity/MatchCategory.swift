//
//  MatchCategory.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import Foundation

enum MatchCategory: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case officialMatch = "공식경기"
    case frendilyMatch = "리그 친선"
    case classicMatch = "클래식 1on1"
    case voltaFrendilyMatch = "볼타 친선"
    case voltaOfficialMatch = "볼타 공식"
    case voltaAIMatch = "볼타 AI대전"
    case voltaCustomMatch = "볼타 커스텀"
    case managerMatch = "감독모드"
}
