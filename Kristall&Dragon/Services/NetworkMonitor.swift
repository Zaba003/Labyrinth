//
//  NetworkMonitor.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")

    @Published var isConnected = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
