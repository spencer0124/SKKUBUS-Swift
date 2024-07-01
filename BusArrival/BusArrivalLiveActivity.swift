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
        var remainingDistance: String
    }
    
    // Fixed non-changing properties about your activity go here!
    var timerName: String
    //    var name: String
}

@available(iOS 16.2, *)
struct BusArrivalLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for:BusArrivalAttributes.self) { context in
            
            Text("hi")
            
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    VStack {
                        Spacer()
                            .frame(height: 1)
                        HStack(spacing: 0) {
                            Spacer()
                                .frame(width: 19)
                            Text("자과캠까지")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))
                           
                        }
                    }
                    
                    
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack {
                        Spacer()
                        context.state.step == 1 ?
                        Text(context.state.message)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .monospacedDigit()
                            .multilineTextAlignment(.center)
                        : Text(timerInterval: Date.now...Date().addingTimeInterval(TimeInterval(context.state.value)), countsDown: true)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .monospacedDigit()
                            .multilineTextAlignment(.center)
                      
                    }
                    
                }
                DynamicIslandExpandedRegion(.center) {
                    
                    
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    HStack(spacing: 0){
                        VStack(alignment: .leading) {
                            Text("인사캠")
                                .font(.system(size: 18, weight: .bold))
                            
                            Text("10:30AM")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(CustomColor.displayGreen1)
                        }
                        
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("자과캠")
                                .font(.system(size: 18, weight: .bold))
                            Text("11:35AM")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(CustomColor.displayGreen1)
                        }
                        
                    }
                    .padding(.horizontal, 19)
                    .padding(.top, 10)
                    
                
                    
                    Spacer()
                        .frame(height: 12)
                    
                    
                    
                    HStack {
                        ProgressView(value: CGFloat((context.state.remainingDistance as NSString).floatValue), total: 100)
                            .tint(CustomColor.displayGreen1)
                            .background(CustomColor.displayGray1)
                            .frame(height: 13) // Manipulate height, y scale effect and corner radius to achieve your needed results
                        //                                            .cornerRadius(30000)
                            .scaleEffect(y: 13)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .padding(.horizontal, 15)
                    
                    
                }
                
                
                
                
            } compactLeading: {
                HStack(spacing: 5) {
                    ZStack {
                        Circle()
                            .strokeBorder(CustomColor.deepgreen,lineWidth: 0)
                            .background(Circle().foregroundColor(CustomColor.deepgreen))
                            .frame(width: 20, height: 20)
                        
//                        Image("skku_logo_clean")
//                            .resizable()
//                            .renderingMode(.template)
//                            .foregroundColor(.white)
//                            .scaledToFit()
//                            .frame(width: 15)
                    }
                    .padding(.leading, 5)
                    Text("출발")
                        .font(.system(size: 14, weight: .medium))
                    
                }
            } compactTrailing: {
                Text(timerInterval: Date.now...Date().addingTimeInterval(TimeInterval(context.state.value)), countsDown: true)
                    .multilineTextAlignment(.leading)
                    .monospacedDigit()
                // frame 설정을 안해주면 오른쪽 정렬처럼 빈공간이 생긴다
                    .frame(maxWidth: .minimum(50, 50))
                
                
                
                
                
            } minimal: {
                Text(timerInterval: Date.now...Date().addingTimeInterval(TimeInterval(context.state.value)), countsDown: true)
                //                    .monospacedDigit()
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(CustomColor.deepgreen)
        }
    }
}





@available(iOS 17.0, *)
//#Preview("Notification", as: .dynamicIsland(.expanded), using: BusArrivalAttributes(timerName: "testtimername")) {
#Preview("Notification", as: .dynamicIsland(.expanded),  using: BusArrivalAttributes(timerName: "testtimername")) {
    BusArrivalLiveActivity()
} contentStates: {
    BusArrivalAttributes.ContentState(value: 3600*2, step: 0, message: "운행종료", remainingDistance: "75")
}

