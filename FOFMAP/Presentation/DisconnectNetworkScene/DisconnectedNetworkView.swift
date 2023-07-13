//
//  NetworkingErrorView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import SwiftUI

struct DisConnectedNetworkView: View {
    var body: some View {
        VStack {
            Image(systemName: "wifi.circle.fill")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text("인터넷 연결을 확인해주세요")
        }
    }
}

struct DisConnectedNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        DisConnectedNetworkView()
    }
}

