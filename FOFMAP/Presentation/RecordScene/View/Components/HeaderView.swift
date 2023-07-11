//
//  HeaderView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/11.
//

import SwiftUI

struct HeaderView: View {
    private let nickname: String
    private let level: Int
    private let grade: String
    
    init(nickname: String, level: Int, grade: String) {
        self.nickname = nickname
        self.level = level
        self.grade = grade
    }
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
            
            VStack {
                Text(nickname.uppercased())
                    .font(.title)
                    .padding(.bottom, 3)
                
                Text("레벨 : \(level)")
            }
            
            Spacer()
            
            VStack {
                Text("최고등급 - \(grade)")
                    .padding(.bottom, 5)
                Text("달성일 - 2022.03.03")
            }
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(CustomColor.gradeBackgroundColor)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(nickname: "민수쨔응", level: 200, grade: "챔피언스")
    }
}
