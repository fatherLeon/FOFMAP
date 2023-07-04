//
//  ContentView.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/27.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                SearchView()
                    .navigationTitle("FOFMAP")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        PickerView()
                    }
            }
            .padding()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
