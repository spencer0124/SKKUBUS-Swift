//
//  BusArrivalLiveActivity.swift
//  BusArrival
//
//  Created by 조승용 on 2023/12/22.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct BusArrivalAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct BusArrivalLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BusArrivalAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension BusArrivalAttributes {
    fileprivate static var preview: BusArrivalAttributes {
        BusArrivalAttributes(name: "World")
    }
}

extension BusArrivalAttributes.ContentState {
    fileprivate static var smiley: BusArrivalAttributes.ContentState {
        BusArrivalAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: BusArrivalAttributes.ContentState {
         BusArrivalAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: BusArrivalAttributes.preview) {
   BusArrivalLiveActivity()
} contentStates: {
    BusArrivalAttributes.ContentState.smiley
    BusArrivalAttributes.ContentState.starEyes
}
