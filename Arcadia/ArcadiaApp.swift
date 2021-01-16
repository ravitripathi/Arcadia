//
//  ArcadiaApp.swift
//  Arcadia
//
//  Created by Ravi Tripathi on 25/12/20.
//

import SwiftUI
import WidgetKit

@main
struct ArcadiaApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
            if checkAndSetLastRunDate() {
                Text("Running from Xcode")
            }
        }
    }
    
    func checkAndSetLastRunDate() -> Bool {
        let isBeingDebugged = amIBeingDebugged()
        if isBeingDebugged {
            StorageBackedKeys.lastRunDate = Date()
        }
        return isBeingDebugged
    }

    func amIBeingDebugged() -> Bool {
        var info = kinfo_proc()
        var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = MemoryLayout<kinfo_proc>.stride
        let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
}
