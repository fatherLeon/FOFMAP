//
//  Bundle+Extension.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/07.
//

import Foundation

extension Bundle {
    static var nexonAPIKey: String {
        guard let filePath = Bundle.main.url(forResource: "APIKey", withExtension: "plist"),
              let resource = try? NSDictionary(contentsOf: filePath, error: ()),
              let apiKey = resource["nexonAPIKey"] as? String else {
            fatalError("Not exist Nexon APIKey")
        }
        
        return apiKey
    }
}
