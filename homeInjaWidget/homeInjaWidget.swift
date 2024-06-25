//
//  homeInjaWidget.swift
//  homeInjaWidget
//
//  Created by 조승용 on 6/24/24.
//

import WidgetKit
import SwiftUI


extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}



struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct homeInjaWidgetEntryView : View {
    var entry: Provider.Entry
   
    
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemMedium:
            
            HStack(alignment: .center){
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    Spacer().frame(height:0.01)
                    
                    VStack(spacing: 2.8){
                        Spacer().frame(height:0.3)
                        HStack {
                            
                            Text("06/24 월요일")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.gray)
                            Spacer()
                            
                        }
                        HStack {
                            Text("인사캠 → 자과캠")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.black)
                            Spacer()
                            
                        }
                        
                        
                    }
                    
                   
                    Spacer().frame(height: 0.01)
                    VStack(alignment: .leading, spacing: 5.5){
                        HStack(spacing: 5.5) {
                            Text("07:00")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
                            
                            Text("10:00")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 4).fill(Color(hex: 0xFF003626)))
                            Text("12:00")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
                            Text("15:00")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
                            Text("16:30")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
                        }
                        .monospacedDigit()
                       
                        
                        
                        HStack(spacing: 5.5) {
                           
                            Text("18:00")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
                            Text("19:00")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
//                            Text("19:00")
//                                .font(.system(size: 14, weight: .medium))
//                                .foregroundColor(.white)
//                                .padding(3)
//                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
//                            Text("19:00")
//                                .font(.system(size: 14, weight: .medium))
//                                .foregroundColor(.white)
//                                .padding(3)
//                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
//                            Text("19:00")
//                                .font(.system(size: 14, weight: .medium))
//                                .foregroundColor(.white)
//                                .padding(3)
//                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
                          
                        }
                        .monospacedDigit()
                    }
                    
                    Spacer().frame(height:0.1)
                    Spacer()
                    
                    
                    
               
                }
                Spacer()
            }
            
            
//            .padding(25)
            .padding(.leading, 25)
            .padding(.trailing, 20)
            .background(Color.white)
            .cornerRadius(15)
            .widgetURL(URL(string: "skkubus://campusbus/main"))
        @unknown default:
            VStack {
                Text("Time:")
                Text(entry.date, style: .time)

                Text("Favorite Emoji:")
                Text(entry.configuration.favoriteEmoji)
            }
        }
        
        
    }
}

struct homeInjaWidget: Widget {
    let kind: String = "homeInjaWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            homeInjaWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .contentMarginsDisabled()
        .configurationDisplayName("인자셔틀 시간표")
        .description("인자셔틀/자인셔틀 시간표")
        .supportedFamilies([.systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

@available(iOS 17.0, *)
#Preview(as: .systemMedium) {
    homeInjaWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
