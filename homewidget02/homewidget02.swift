//
//  homewidget02.swift
//  homewidget02
//
//  Created by 조승용 on 2023/12/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct homewidget02EntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        ZStack {
            ContainerRelativeShape()
                .fill(LinearGradient(gradient: Gradient(colors: [.customDeepGreen2, .customDeepGreen3, .customDeepGreen4]), startPoint: .topLeading, endPoint: .bottomTrailing))
                
            
            VStack {
                HStack{
                    Image("skkulogo1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    Spacer()
                }
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("스꾸라이프")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                        Text("인사캠 셔틀버스")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }.padding(8)
                    
                    
                    Spacer()
                }
                    
                
            }.padding(10)
        }
    }
       
}

struct homewidget02: Widget {
    let kind: String = "homewidget02"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                homewidget02EntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                homewidget02EntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .contentMarginsDisabled()
        .configurationDisplayName("스꾸버스")
        .description("인사캠 셔틀버스 바로가기")
    }
}

#Preview(as: .systemSmall) {
    homewidget02()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
