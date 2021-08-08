//
//  GitBrowserWidget.swift
//  GitBrowserWidget
//
//  Created by Ravi Tripathi on 25/07/20.
//

import WidgetKit
import SwiftUI
import Intents
import GitBrowser

// Struct for data in widget
struct GithubUserEntry: TimelineEntry {
    let date: Date
    let userData: User
    let imageData: Data
}

// Dynamic, confiurable widget
// Contains logic for updating/viewing the widget
struct GitBrowserIntentTimelineProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> GithubUserEntry {
        let user = User()
        user.name = "Here's one dummy user"
        user.login = "@userloginhere"
        let imgData = UIImage(systemName: "person")!.pngData()!
        return GithubUserEntry(date: Date(), userData: user, imageData: imgData)
    }
    
    typealias Entry = GithubUserEntry
    
    typealias Intent = GitBrowserIntent
    
    func getSnapshot(for configuration: GitBrowserIntent, in context: Context, completion: @escaping (GithubUserEntry) -> Void) {
        let user = User()
        user.name = "Here's one dummy user"
        user.login = "@userloginhere"
        let imgData = UIImage(systemName: "person")!.pngData()!
        let entry = GithubUserEntry(date: Date(), userData: user, imageData: imgData)
        completion(entry)
    }
    
    func getTimeline(for configuration: GitBrowserIntent, in context: Context, completion: @escaping (Timeline<GithubUserEntry>) -> Void) {
        
        var username = AppData.lastCurrentUsername
        if let u = configuration.username, !u.isEmpty {
            username = u
        }
        NetworkManager.shared.getUserDetails(forUsername: username) { (user) -> (Void) in
            let dummyUser = User()
            dummyUser.name = "Here's one dummy user"
            dummyUser.login = "@userloginhere"
            let imgData = UIImage(systemName: "person")!.pngData()!
            let emptyTimeLine = Timeline(entries: [GithubUserEntry(date: Date(), userData: dummyUser, imageData: imgData)], policy: .atEnd)
            guard let user = user, let userImageUrlS = user.avatar_url, let userImageUrl = URL(string: userImageUrlS) else {
                completion(emptyTimeLine)
                return
            }
            
            URLSession.shared.dataTask(with: userImageUrl) { (data, resp, error) in
                guard let data = data else {
                    completion(emptyTimeLine)
                    return
                }
                let entry = GithubUserEntry(date: Date(), userData: user, imageData: data)
                //Policy decides when to reload the widget. never -> remains fixed
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            }.resume()
        }
    }
}

//What the widget should look like
struct WidgetEntryView: View {
    
    let entry: GitBrowserIntentTimelineProvider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder //Allows adding switch statements to the view
    var body: some View {
        switch family {
        default:
            MediumWidget(user: entry.userData, imageData: entry.imageData)
        }
        
    }
}

public struct GitBrowserWidget: Widget {
    
    private let kind = "GitBrowserWidget"
    
    public init() {}
    
    public var body: some WidgetConfiguration {
        
        IntentConfiguration(kind: kind, intent: GitBrowserIntent.self, provider: GitBrowserIntentTimelineProvider()) { entry in
            WidgetEntryView(entry: entry)
        }.supportedFamilies([.systemMedium])
        .configurationDisplayName("GitBrowser")
        .description("Display GitHub user data")

        //        Use this to set what sizes of widgets you want to support. Also works without it
        
        //        Building static widgets
        //        StaticConfiguration(kind: kind, provider: Provider()) { entry in
        //            WidgetEntryView(entry: entry)
        //        }
        //        .supportedFamilies([.systemMedium])
    }
}

//Static Widget Timeline
//Contains logic for updating/viewing the widget
//struct Provider: IntentTimelineProvider {
//
////    typealias Entry = GithubUserEntry
//    typealias Intent = GithubUserEntry
//
//    //Renders snapshot on home page. Dummy data. Fast returning
//    func getSnapshot(for configuration: Intent, in context: Context, completion: @escaping (GithubUserEntry) -> Void) {
//        let entry = GithubUserEntry(date: Date(), userData: User(), imageData: UIImage(systemName: "person")!.pngData()!)
//        completion(entry)
//    }
//
//
//    func getTimeline(for configuration: Intent, in context: Context, completion: @escaping (Timeline<GithubUserEntry>) -> Void) {
//        NetworkManager.shared.getUserDetails(forUsername: AppData.lastCurrentUsername) { (user) -> (Void) in
//            let emptyTimeLine = Timeline(entries: [GithubUserEntry(date: Date(), userData: User(), imageData: Data())], policy: .atEnd)
//            guard let user = user, let userImageUrlS = user.avatar_url, let userImageUrl = URL(string: userImageUrlS) else {
//                completion(emptyTimeLine)
//                return
//            }
//
//            URLSession.shared.dataTask(with: userImageUrl) { (data, resp, error) in
//                guard let data = data else {
//                    completion(emptyTimeLine)
//                    return
//                }
//                let entry = GithubUserEntry(date: Date(), userData: user, imageData: data)
//                //Policy decides when to reload the widget. never -> remains fixed
//                let timeline = Timeline(entries: [entry], policy: .atEnd)
//                completion(timeline)
//            }.resume()
//        }
//    }
// }
