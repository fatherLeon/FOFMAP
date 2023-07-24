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
                    .font(.title)
                
                Text("레벨 : \(user.level)")
            }
            .padding(.leading, 20)
            
            Spacer()
            
            VStack {
                Text("최고등급 - \(user.grade)")
                    .padding(.bottom, 5)
                Text("달성일 - \(user.gradeDate)")
            }
            .padding(.trailing, 20)
        }
        .foregroundColor(.black)
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
        .background(CustomColor.gradeBackgroundColor)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(user: User(nickname: "123", id: "123", level: 123, grade: "챔피언스", gradeDate: "2022-03-20"))
    }
}
