//
//  RecordCell.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/10.
//

import SwiftUI

struct RecordCell: View {
    var body: some View {
        HStack {
            // 날짜
            VStack {
                Text("2023.05.30.")
                Text("16:40")
            }
            .font(.caption)
            
            Spacer()
            
            Text("1 : 2")
                .bold()
                .font(.title3)
            
            Spacer()
            
            Text("상대 이름")
                .font(.subheadline)
                .lineLimit(3)
            
            Button {
                // 더보기 액션
            } label: {
                Image(systemName: "chevron.right")
            }
            .padding(.leading, 30)

        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

struct RecordCell_Previews: PreviewProvider {
    static var previews: some View {
        RecordCell()
    }
}
