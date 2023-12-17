//
//  DisplayImgWidget.swift
//  DisplayImgWidget
//
//  Created by 榜士靖文 on 2023/12/17.
//

import WidgetKit
import SwiftUI

struct ImageWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: Image("IMG"))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), image: Image("IMG"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, image: Image("IMG"))
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: Image
}

struct DisplayImgWidgetEntryView : View {
    var entry: ImageWidgetProvider.Entry

    var body: some View {
        VStack {
            //Text("Time:")
            //Text(entry.date, style: .time)
            
            //Text("Emoji:")
            //Text(entry.emoji)
            
            Image("IMG")
                .resizable()
                .scaledToFit()
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DisplayImgWidget: Widget {
    let kind: String = "DisplayImgWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ImageWidgetProvider()) { entry in
            if #available(iOS 17.0, *) {
                DisplayImgWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                DisplayImgWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Image Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    DisplayImgWidget()
} timeline: {
    SimpleEntry(date: .now, image: Image("IMG"))
    SimpleEntry(date: .now, image: Image("IMG"))
}
