//
//  ArcadiaWidgets.swift
//  ArcadiaWidgets
//
//  Created by Ravi Tripathi on 16/01/21.
//

import WidgetKit
import SwiftUI
import Intents


struct Provider: IntentTimelineProvider {
    
    typealias Entry = SimpleEntry
    
    typealias Intent = GitBrowserIntentIntent
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(for configuration: GitBrowserIntentIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(for configuration: GitBrowserIntentIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 100 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct ArcadiaWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: entry.date)
        let minutes = calendar.component(.minute, from: entry.date)
        let seconds = calendar.component(.second, from: entry.date)
        Text("\(hour):\(minutes):\(seconds)")
    }
}

struct ArcadiaWidgets: Widget {
    let kind: String = "ArcadiaWidgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: GitBrowserIntentIntent.self, provider: Provider()) { entry in
            ArcadiaWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct ArcadiaWidgets_Previews: PreviewProvider {
    static var previews: some View {
        ArcadiaWidgetsEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
