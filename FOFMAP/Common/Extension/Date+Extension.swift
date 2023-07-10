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
        
        dateFormatter.dateFormat = "YYYY-MM-DD"
        
        return dateFormatter
    }()
    private static var hourToMinuteFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH : mm"
        
        return dateFormatter
    }()
    
    func toYearMonthDateString(_ text: String) -> String? {
        guard let date = Date.ISOFormatter.date(from: text) else {
            return nil
        }
        
        let dateText = Date.yearToDayFormatter.string(from: date)
        
        return dateText
    }
    
    func toHourMinuteString(_ text: String) -> String? {
        guard let date = Date.ISOFormatter.date(from: text) else {
            return nil
        }
        
        let dateText = Date.hourToMinuteFormatter.string(from: date)
        
        return dateText
    }
}
