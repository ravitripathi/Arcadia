//
//  LandingView.swift
//  Arcadia
//
//  Created by Ravi Tripathi on 25/12/20.
//

import SwiftUI
import GitBrowser
import EyeTracker
import FLEX
import AppStoreCard

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
                NavigationLink(
                    destination:
                        AppStoreCard.AppStoreCardView(),
                    label: {
                        Text("App Store Card")
                    })
            }.navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("Arcadia")
                        Button("Launch Flex") {
                            FLEXManager.shared.showExplorer()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .preferredColorScheme(.dark)
    }
}
