//
//  FOFMAPApp.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/06/27.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct FOFMAPApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @ObservedObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
//            if networkMonitor.isConnected {
//                MainView(viewModel: MainViewModel())
//            } else {
//                DisConnectedNetworkView()
//            }
            
            MainView(viewModel: MainViewModel())
        }
    }
}
