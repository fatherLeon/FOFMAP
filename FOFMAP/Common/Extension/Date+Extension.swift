//
//  Date+Extension.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import Foundation

extension Date {
    private static let ISOFormatter = ISO8601DateFormatter()
    private static var yearToDayFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY.MM.dd."
        
        return dateFormatter
    }()
    private static var hourToMinuteFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH : mm"
        
        return dateFormatter
    }()
    
    static func toYearMonthDateString(_ text: String) -> String {
        guard let date = Date.ISOFormatter.date(from: text + "Z") else {
            return "날짜 정보 없음"
        }
        
        let dateText = Date.yearToDayFormatter.string(from: date)
        
        return dateText
    }
    
    static func toHourMinuteString(_ text: String) -> String {
        guard let date = Date.ISOFormatter.date(from: text + "Z") else {
            return ""
        }
        let dateText = Date.hourToMinuteFormatter.string(from: date)
        
        return dateText
    }
}
