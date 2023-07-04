//
//  FOFMAPApp.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/27.
//

import SwiftUI

@main
struct FOFMAPApp: App {
    
    @ObservedObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            if networkMonitor.isConnected {
                MainView()
            } else {
                NetworkingErrorView()
            }
        }
    }
}
