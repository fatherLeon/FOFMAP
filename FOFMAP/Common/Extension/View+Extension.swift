//
//  View+Extension.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/05.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
