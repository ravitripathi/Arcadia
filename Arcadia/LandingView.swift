//
//  LandingView.swift
//  Arcadia
//
//  Created by Ravi Tripathi on 25/12/20.
//

import SwiftUI
import GitBrowser
import EyeTracker

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
                NavigationLink(
                    destination:
                        EyeTracker.EyeTrackerView(),
                    label: {
                        Text("EyeTracker")
                    })
                
            }.navigationBarTitle(Text("Arcadia"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .preferredColorScheme(.dark)
    }
}
