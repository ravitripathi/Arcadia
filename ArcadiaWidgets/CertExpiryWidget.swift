//
//  CertExpiryWidget.swift
//  CertExpiryWidget
//
//  Created by Ravi Tripathi on 16/01/21.
//

import WidgetKit
import SwiftUI
import Intents


struct CertExpiryWidgetProvider: TimelineProvider {
    typealias Entry = SimpleEntry
    typealias Intent = GitBrowserIntent

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = Entry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [Entry] = []

        // Generate a timeline consisting of eight entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let entry = Entry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> Entry {
        Entry(date: Date())
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct CertExpiryWidgetEntryView : View {
    var entry: CertExpiryWidgetProvider.Entry
    
    var body: some View {
        VStack {
            if getNumberOfDaysRemaining() > 0 {
                HStack {
                    Text("\(getNumberOfDaysRemaining())")
                        .foregroundColor(getColor())
                        .font(.system(size: 45))
                    VStack(alignment: .leading) {
                        Text("days")
                        Text("remaining")
                    }
                }
            } else {
                VStack {
                    Text("Certificate")
                        .foregroundColor(.red)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    Text("Expired")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
            }
            Text("Last ran from Xcode on: \(getFormattedDate())")
                .font(.system(size: 12))
        }.padding()
    }
    
    func getColor() -> Color {
        let day = getNumberOfDaysRemaining()
        if day >= 4 {
            return Color.green
        } else if day == 2 || day == 3 {
            return Color.yellow
        } else {
            return Color.red
        }
    }
    
    func getNumberOfDaysRemaining() -> Int {
        let lastRunDate = StorageBackedKeys.lastRunDate
        var dateComponent = DateComponents()
        dateComponent.day = 7
        let expiryDate = Calendar.current.date(byAdding: dateComponent, to: lastRunDate)!
        let currentDate = entry.date
        if expiryDate > currentDate {
            let difference = Calendar.current.dateComponents([.day], from: currentDate, to: expiryDate)
            return difference.day ?? 0
        } else {
            return 0
        }
    }
    
    func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: StorageBackedKeys.lastRunDate)
    }
}

struct CertExpiryWidget: Widget {
    let kind: String = "CertExpiryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CertExpiryWidgetProvider()) { entry in
            CertExpiryWidgetEntryView(entry: entry)
        }.configurationDisplayName("Arcadia Certificate Widget")
        .description("Shows last run date from Xcode and number of days remaining for expiry")
        .supportedFamilies([.systemSmall])
    }
}

struct ArcadiaWidgets_Previews: PreviewProvider {
    static var previews: some View {
        CertExpiryWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
