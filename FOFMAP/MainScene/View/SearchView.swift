//
//  SearchTextField.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import SwiftUI

struct SearchView: View {
    
    @State var playerName: String = ""
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack(alignment: .trailing) {
                TextField("선수 이름 검색", text: $playerName)
                    .border(.background)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .textFieldStyle(.roundedBorder)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black)
                    }
                
                if playerName != "" {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.medium)
                        .foregroundColor(Color(.systemGray3))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        .onTapGesture {
                            self.playerName = ""
                        }
                }
            }
            
            Button {
                // 버튼 액션
            } label: {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
                .font(.title3)
                .foregroundColor(.green)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.green)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
