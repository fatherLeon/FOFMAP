//
//  RecordView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/07.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        NavigationView {
            List {
                Text("abc")
                Text("abc")
                Text("abc")
                Text("abc")
                Text("abc")
                Text("abc")
            }
            .listStyle(.inset)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("유저이름")
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
