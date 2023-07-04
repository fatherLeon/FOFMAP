//
//  NetworkMonitor.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/04.
//

import Network
import Foundation

class NetworkMonitor: ObservableObject {
    @Published var isConnected: Bool = true
    private let networkMonitor: NWPathMonitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .unspecified)
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        
        networkMonitor.start(queue: queue)
    }
    
    deinit {
        networkMonitor.cancel()
    }
}