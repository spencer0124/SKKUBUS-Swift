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
        var value: Int
        var step: Int
        var message: String
    }
    
    // Fixed non-changing properties about your activity go here!
    var timerName: String
//    var name: String
}

@available(iOS 16.2, *)
struct BusArrivalLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for:BusArrivalAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                HStack {
                    HStack {
                        ZStack {
                            Circle()
                                .strokeBorder(Color.blue,lineWidth: 0)
                                .background(Circle().foregroundColor(.green))
                                .frame(width: 20, height: 20)
                            
                            
                            Text("마을")
                                .foregroundColor(.white)
                                .font(.system(size: 9, weight: .medium))
                        }
                        .padding(.leading, 5)
                        Text("종로07")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .medium))
                    }
                    Spacer()
                    Text("혜화역1번출구")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .medium))
                        .padding(.trailing, 5)
                }
                
                context.state.step == 1 ?
                
                Text(context.state.message)
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .bold))
                    .monospacedDigit()
                    .multilineTextAlignment(.center)
                : Text(timerInterval: Date.now...Date().addingTimeInterval(TimeInterval(context.state.value)), countsDown: true)
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold))
                    .monospacedDigit()
                    .multilineTextAlignment(.center)
            }
            .padding()
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(Color.white)
            
        } dynamicIsland: { context in
            DynamicIsland {
                
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        ZStack {
                            Circle()
                                .strokeBorder(Color.blue,lineWidth: 0)
                                .background(Circle().foregroundColor(.green))
                                .frame(width: 20, height: 20)
                            
                            
                            Text("마을")
                                .font(.system(size: 9, weight: .medium))
                        }
                        .padding(.leading, 5)
                        Text("종로07")
                            .font(.system(size: 14, weight: .medium))
                    }
                    
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("혜화역1번출구")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.trailing, 5)
                }
                DynamicIslandExpandedRegion(.center) {
                    
                }
//                DynamicIslandExpandedRegion(.bottom) {
//                    VStack(alignment:.center) {
//                        Spacer()
//                        
//                       
//                        Text(context.state.endTime, style: .timer)
//                                .font(.system(size: 40, weight: .bold))
//                                .monospacedDigit()
//                                .multilineTextAlignment(.center)
//                        
//                        Spacer()
//                        }
//                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(alignment: .center) {
                        Spacer()
                        context.state.step == 1 ?
                        Text(context.state.message)
                            .font(.system(size: 30, weight: .bold))
                            .monospacedDigit()
                            .multilineTextAlignment(.center)
                        : Text(timerInterval: Date.now...Date().addingTimeInterval(TimeInterval(context.state.value)), countsDown: true)
                            .font(.system(size: 40, weight: .bold))
                            .monospacedDigit()
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                }




            } compactLeading: {
                HStack() {
                    ZStack {
                        Circle()
                            .strokeBorder(Color.blue,lineWidth: 0)
                            .background(Circle().foregroundColor(Color.green))
                            .frame(width: 20, height: 20)
                        Text("마을")
                            .font(.system(size: 9, weight: .bold))
                    }
                    Text("혜화역1번출구")
                        .font(.system(size: 14, weight: .bold))
                        .padding(.leading, 2)
                }
            } compactTrailing: {
               

                Text(timerInterval: Date.now...Date().addingTimeInterval(TimeInterval(context.state.value)), countsDown: true)
                        .multilineTextAlignment(.trailing)
                        .monospacedDigit()
            } minimal: {
                Text(timerInterval: Date.now...Date().addingTimeInterval(TimeInterval(context.state.value)), countsDown: true)
//                    .monospacedDigit()
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(.customDeepGreen1)
        }
    }
}





@available(iOS 17.0, *)
//#Preview("Notification", as: .dynamicIsland(.expanded), using: BusArrivalAttributes(timerName: "testtimername")) {
#Preview("Notification", as: .content,  using: BusArrivalAttributes(timerName: "testtimername")) {
    
    
    BusArrivalLiveActivity()
} contentStates: {
    BusArrivalAttributes.ContentState(value: 120, step: 0, message: "운행종료")
}

