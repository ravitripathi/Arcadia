//
//  ArcadiaWidgetBundle.swift
//  Arcadia
//
//  Created by Ravi Tripathi on 16/01/21.
//

import WidgetKit
import SwiftUI
import GitBrowser

@main
struct ArcadiaWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        CertExpiryWidget()
        GitBrowserWidget()
    }
}
