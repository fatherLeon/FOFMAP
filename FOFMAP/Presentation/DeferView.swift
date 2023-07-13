//
//  DeferView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/13.
//

import SwiftUI

struct DeferView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        content()
    }
}
