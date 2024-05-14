//
//  Jongro07BusListView.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

import SwiftUI

struct Jongro07BusListView: View {
    var body: some View
    
    {
        
        @ObservedObject var Jongro07BusMainViewModel = Jongro07BusMainVM()
        
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                ZStack {
                    VStack(spacing:0) {
                        Spacer()
                            .frame(height: 5)
                            .id("ScrollTop")
                        ForEach(Jongro07BusMainViewModel.stations, id: \.stationId) { station in
                            HSSCBusListComponentView(
                                stationName: station.name,
                                stationNumber: String(station.stationId),
                                eta: station.StationMessage,
                                isFirstStation: station.isFirstStation,
                                isLastStation: station.isLastStation,
                                isRotationStation: station.isRotationStation
                            )
                        }
                        Spacer()
                            .frame(height: 25)
                        Rectangle()
                            .fill(Color.gray)
                            .opacity(0.4)
                            .frame(height: 0.2)
                        Spacer()
                            .frame(height: 25)
                        ZStack {
                            Circle()
                                .strokeBorder(Color.gray, lineWidth: 1)
                                .opacity(0.3)
                                .foregroundColor(Color.white)
                                .frame(width: 35, height: 35)
                            Image(systemName: "arrow.up")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .onTapGesture {
                            withAnimation{proxy.scrollTo("ScrollTop", anchor: .top)}
                            
                        }
                        Spacer()
                            .frame(height: 50)
                        
                    }
                    
                    /*
                     ZStack의 두번째 구성요소.
                     버스 번호판과 버스를 겹쳐서 표시해주기 위해 사용
                     */
                    
                    
                    VStack {
                        Spacer()
                            .frame(height: 5 + 21 + 66 * 16)
                        HStack {
                            Spacer()
                                .frame(width: BusConstants.BusMainLeftSpace-65)
                            LicensePlate()
                                .foregroundColor(.green)
                            HSSCBusAnimation()
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                            .frame(height: 5 + 21 + 66 * 1)
                        HStack {
                            Spacer()
                                .frame(width: BusConstants.BusMainLeftSpace-65)
                            LicensePlate()
                                .foregroundColor(.green)
                            HSSCBusAnimation()
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
        }
    }
}

#Preview {
    Jongro07BusListView()
}
