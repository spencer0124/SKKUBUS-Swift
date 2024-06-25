//
//  Jongro07BusListView.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

import SwiftUI

struct MainBusListView: View {
    
    @ObservedObject var MainBusMainViewModel = MainBusMainVM()

    var busType: BusType
    
    
    
    var body: some View
    
    {
        var busMainColor = busType.getBusColor()
        
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                ZStack {
                    VStack(spacing:0) {
                        Spacer()
                            .frame(height: 5)
                            .id("ScrollTop")
                        ForEach(getStations(for: busType), id: \.internalStationId) { station in
                            MainBusListComponentView(
                                stationName: station.stationName,
                                externalStationId: String(station.externalStationId),
                                eta: station.eta,
                                isFirstStation: station.isFirstStation,
                                isLastStation: station.isLastStation,
                                isRotationStation: station.isRotationStation,
                                busMainColor: busMainColor
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
                            MainBusAnimation(busMainColor: busMainColor)
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
                            MainBusAnimation(busMainColor: busMainColor)
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
    private func getStations(for busType: BusType) -> [MainBusStation] {
            switch busType {
            case .HSSCBus:
                return MainBusMainViewModel.HSSCstations
                // TOdo: change campusbus
            case .CampusBus:
                return MainBusMainViewModel.HSSCstations
            case .Jongro07Bus, .Jongro02Bus, .Jongro08Bus:
                return MainBusMainViewModel.Jongro07stations
            }
        }
}

#Preview {
    MainBusListView(busType: BusType.HSSCBus)
}
