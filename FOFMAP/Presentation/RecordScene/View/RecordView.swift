//
//  RecordView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/07.
//

import SwiftUI

struct RecordView: View {
    @State var matchCategory: MatchCategory = .classicMatch
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    NavigationLink {
                        Text("Destination")
                    } label: {
                        RecordCell()
                    }
                }
            }
            .navigationTitle("유저 이름")
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
