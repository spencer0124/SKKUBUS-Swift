//
//  Jongro07BusMainView.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/30.
//

import SwiftUI
import Lottie

struct MainBusMainView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    var busType: BusType
    
    var body: some View {
        
        ZStack(alignment: .top) {
            TopSafeAreaColorView(color:busType.getBusColor())
            
            
            VStack(spacing:0) {
                BusMainNavigationBar(
                    title: busType.getBusTitle(),
                    backgroundColor: busType.getBusColor(),
                    isDisplayLeftBtn: true,
                    isDisplayRightBtn: true,
                    leftBtnAction:  {
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    RightBtnAction: {},
                    RightBtnType: .info
                )
                
                
                TopInfo(timeFormat: .Format12Hour, busCount: 3, busStatus: .active)
                MainBusListView(busType: busType)
            }
            
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    HSSCRefreshButton(busType: busType)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 10)
                
            }
        }
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: nil) {
            BottomAdView()
                .frame(maxWidth: .infinity)
                .background(Color.init(hex: 0xFFE8E9EB))
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    print("active now!")
                }
    }
    
    
}





// MARK: - preview
#Preview {
    MainBusMainView(busType: BusType.HSSCBus)
}
