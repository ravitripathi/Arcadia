//
//  LandingView.swift
//  Arcadia
//
//  Created by Ravi Tripathi on 25/12/20.
//

import SwiftUI
import GitBrowser
import EyeTracker
import AppStoreCard
#if canImport(FLEX)
import FLEX
#endif

struct LandingView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
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
                            AppStoreCard.CardListView(),
                        label: {
                            Text("Card List Views")
                        })
                    NavigationLink(
                        destination: FancyText(),
                        label: {
                            Text("Fancy Text")
                        })
                }
                .listStyle(InsetGroupedListStyle())
                #if canImport(FLEX)
                Button("Launch Flex") {
                    FLEXManager.shared.showExplorer()
                }
                #endif
            }
            .navigationBarTitleDisplayMode(.large)
            .lineSpacing(0.0)
            .navigationTitle("Arcadia")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .preferredColorScheme(.dark)
    }
}
