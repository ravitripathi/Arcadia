//
//  LandingView.swift
//  Arcadia
//
//  Created by Ravi Tripathi on 25/12/20.
//

import SwiftUI
import GitBrowser

struct LandingView: View {
    var body: some View {
        NavigationView {
            List {
                    NavigationLink(
                        destination:
                            GitBrowser.ContentView().environmentObject(NetworkStore()),
                        label: {
                            Text("GitBrowser")
                        })
                
            }.navigationBarTitle(Text("Arcadia: \(amIBeingDebugged() ? "DEBUG" : "NOPE")"))
        }
    }
}

func amIBeingDebugged() -> Bool {
    var info = kinfo_proc()
    var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
    var size = MemoryLayout<kinfo_proc>.stride
    let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
    assert(junk == 0, "sysctl failed")
    return (info.kp_proc.p_flag & P_TRACED) != 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .preferredColorScheme(.dark)
    }
}
