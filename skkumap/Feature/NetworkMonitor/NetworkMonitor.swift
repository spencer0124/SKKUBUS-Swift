// NetworkMonitor.swift
// skkumap
// Created by 조승용 on 2024/05/14.

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    @Published var isConnected: Bool = true
    
    private var monitor: NWPathMonitor?
    private var queue = DispatchQueue.global(qos: .background)
    
    init() {
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    private func startMonitoring() {
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor?.start(queue: queue)
    }
    
    private func stopMonitoring() {
        monitor?.cancel()
        monitor = nil
    }
}
