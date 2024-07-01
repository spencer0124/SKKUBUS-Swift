//
//  CampusBusView.swift
//  skkumap
//
//  Created by 조승용 on 6/24/24.
//

import SwiftUI
import ActivityKit

struct ScheduleItem: Identifiable {
    var id = UUID()
    var time: String
    var count: String
   
}

let scheduleData = [
    ScheduleItem(time: "07:00", count: "1"),
    ScheduleItem(time: "08:00", count: "0"),
    ScheduleItem(time: "10:00", count: "1"),
    ScheduleItem(time: "12:00", count: "1"),
    ScheduleItem(time: "15:00", count: "1"),
    ScheduleItem(time: "16:30", count: "1"),
    ScheduleItem(time: "18:00", count: "1"),
    ScheduleItem(time: "19:00", count: "1")
]

struct ScheduleTableView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header row
            HStack {
                Spacer()
                Text("운영시간")
                    .font(.headline)
                    .foregroundColor(.blue)
                Spacer()
                Text("운영대수")
                    .font(.headline)
                    .foregroundColor(.blue)
                Spacer()
                
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            
            // Data rows
            ForEach(scheduleData) { item in
                HStack {
                    Spacer()
                    Text(item.time)
                        .frame(width: 60, alignment: .leading)
                    Spacer()
                    Text(item.count)
                        .frame(width: 40, alignment: .center)
                    Spacer()
                    
                }
                .padding(.vertical, 5)
                .padding(.horizontal)
                Divider()
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .onAppear {
            AppState.shared.swipeEnabled = true
        }
        .onDisappear {
            AppState.shared.swipeEnabled = false
            
        }
    }
}



struct CampusBusView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    @Binding var path: NavigationPath
    
    @State private var selectedOption = "인자셔틀"
    let options = ["인자셔틀", "자인셔틀"]
    
   
    
    
    
    var body: some View {
        
        ZStack(alignment: .top) {
            TopSafeAreaColorView(color: BusType.CampusBus.getBusColor())
            
            
            VStack(spacing:0) {
                BusMainNavigationBar(
                    title: BusType.CampusBus.getBusTitle(),
                    backgroundColor: BusType.CampusBus.getBusColor(),
                    isDisplayLeftBtn: true,
                    isDisplayRightBtn: true,
                    leftBtnAction:  {
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    RightBtnAction: {},
                    RightBtnType: .info
                )
                Spacer().frame(height: 13)
                optionPicker
                Spacer().frame(height: 13)
                
                TransitInfoView()
                Spacer().frame(height: 13)
                                if #available(iOS 16.2, *) {
                                    Button("Start Acitivty") {
                
                                        print("button 1")
                
                                        let busArrivalLiveAttributes = BusArrivalAttributes(timerName: "testtimername")
                                        let contentState = BusArrivalAttributes.ContentState(value: 7000, step: 0, message: "test", remainingDistance: "75")
                                        do {
                                            let activity = try Activity<BusArrivalAttributes>.request(
                                                attributes: busArrivalLiveAttributes,
                                                contentState: contentState,
                                                pushType: .token
                
                                            )
                                            print("button 2")
                                            let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
                                            Task {
//                                                for try await token in activity.pushTokenUpdates {
//                                                    let tokenParts = token.map { data in String(format: "%02.2hhx", data) }
//                                                    let token = tokenParts.joined()
//                                                    print("Live activity token updated: \(token)")
//                
//                                                    let db = Firestore.firestore()
//                
//                
//                                                    do {
//                                                        try await db.collection("bus/token/push_tokens")
//                                                            .document(deviceId)
//                                                            .setData([ "token": token ])
//                                                        print("success, token: \(token)")
//                                                    } catch {
//                                                        print("failed to update token: \(error.localizedDescription)")
//                                                    }
//                                                }
                                            }
                                            print("button 3")
                                        } catch {
                                            print("button error")
                                            print(error)
                                        }
                                    }
                
                
                                }
                
            }
            
        }
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: nil) {
            BottomAdView()
                .frame(maxWidth: .infinity)
                .background(Color.init(hex: 0xFFE8E9EB))
        }
        
        
    }
    
    
    
    private var optionPicker: some View {
        Picker("Options", selection: $selectedOption) {
            ForEach(options, id: \.self) { option in
                Text(option).tag(option)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 10)
        .background(Color.white)
        .onChange(of: selectedOption) { newValue in
            // do something
        }
    }
    
    

    struct TransitInfoView: View {
        var body: some View {
            VStack(spacing: 0) { // Set spacing to 0 to avoid gaps between VStack elements
                VStack {
                    HStack {
                       
                        HStack(spacing: 4){
                            VStack(alignment: .leading, spacing: 1) {
                                Text("인사캠")
                                    .font(.system(size: 18, weight: .semibold))
                                    
                                Text("10:26AM")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(CustomColor.deepgreen)
                            }
                            
                            Spacer()
                            HStack {
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.gray.opacity(0.2))
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.gray.opacity(0.4))
                                Image("skku_logo_clean")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.gray.opacity(1.2))
                                   
                                    .scaledToFit()
                                    .frame(width: 35)
                                    
                                   
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.gray.opacity(0.4))
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.gray.opacity(0.2))
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 1) {
                                Text("자과캠")
                                    .font(.system(size: 18, weight: .semibold))
                                    
                                Text("11:35AM")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(CustomColor.deepgreen)
                            }
                        
                        }
                        .padding(.horizontal, 19)
                        .padding(.top, 15)
                    }
                    .padding(.bottom)
                }
                .frame(height: 120) // 위쪽 파트 높이
                .background(Color.gray.opacity(0.1))
                
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 50) // 아래쪽 파트 높이
                        .clipShape(
                            .rect(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 20,
                                bottomTrailingRadius: 20,
                                topTrailingRadius: 0
                            )
                        )
                    HStack {
                        Text("인사캠 출발")
                            .font(.headline)
                        
                        Text("4분 29초")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                    }
                }
                Spacer().frame(height: 15)
//                ScheduleTableView()
                
            }
            .cornerRadius(20)
            .padding([.horizontal, .bottom])
        }
    }

        
    }


#Preview {
    CampusBusView(
        path: .constant(NavigationPath())
    )
}
