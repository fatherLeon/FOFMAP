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
            VStack {
                Text(nickname)
                    .font(.title)
                    .padding(.bottom, 10)
                
                Text("레벨 : \(level)")
            }
            
            Spacer()
            
            VStack {
                Text("최고등급 - \(grade)")
                    .padding(.bottom, 10)
                Text("달성일 - 2022.03.03")
            }
        }
        .background(CustomColor.gradeBackgroundColor)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(nickname: "민수쨔응", level: 200, grade: "챔피언스")
    }
}
