//
//  ChargingManager.swift
//  ChargingMaster
//
//  Created by 张哲炜 on 2021/8/5.
//

import Foundation
import UIKit

struct Battery {
    var level: Float
    var state: UIDevice.BatteryState
}

class BatteryManager: NSObject {
    
    static let shared = BatteryManager()
    
    var battery: Observable<Battery>
    private var _batteryLevel: Float { UIDevice.current.batteryLevel }
    private var _batteryState: UIDevice.BatteryState { UIDevice.current.batteryState }
    
    private override init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        battery = Observable(Battery.init(level: UIDevice.current.batteryLevel,
                                          state: UIDevice.current.batteryState))
        super.init()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func startMonitor() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateBatteryLevel(notification:)), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBatteryState(notification:)), name: UIDevice.batteryStateDidChangeNotification, object: nil)
    }
    
    @objc func updateBatteryLevel(notification: NSNotification) {
        battery.value.level = _batteryLevel
    }
    
    @objc func updateBatteryState(notification: NSNotification) {
        battery.value.state = _batteryState
    }
    
}
