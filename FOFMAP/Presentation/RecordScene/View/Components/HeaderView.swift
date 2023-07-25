//
//  HeaderView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/11.
//

import SwiftUI

struct HeaderView: View {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(user.nickname.uppercased())
                    .font(.body)
                
                Text("레벨 : \(user.level)")
                    .font(.caption)
            }
            .padding(.leading, 20)
            
            Spacer()
            
            VStack {
                Text("최고등급 - \(user.grade)")
                    .font(.caption)
                    .padding(.bottom, 5)
                Text("달성일 - \(user.gradeDate)")
                    .font(.caption)
            }
            
            DivisionIcon.divisionIcon(user.gradeId)
        }
        .foregroundColor(.black)
        .background(CustomColor.gradeBackgroundColor)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(user: User(nickname: "123", id: "123", level: 123, grade: "챔피언스", gradeDate: "2022-03-20", gradeId: 2700))
    }
}
