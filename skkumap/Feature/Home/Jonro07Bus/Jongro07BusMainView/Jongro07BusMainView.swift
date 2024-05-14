//
//  Jongro07BusMainView.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/30.
//

import SwiftUI
import Lottie

struct Jongro07BusMainView: View {
    
    var body: some View {
        
        ZStack(alignment: .top) {
            TopSafeAreaColorView()
            
            
            VStack(spacing:0) {
                BusMainNavigationBar(
                    title: "종로 07",
                    backgroundColor: .green,
                    isDisplayLeftBtn: true,
                    isDisplayRightBtn: true,
                    leftBtnAction:  {},
                    RightBtnAction: {},
                    RightBtnType: .info
                )
                
                
                TopInfo(timeFormat: .Format12Hour, busCount: 3, busStatus: .active)
                Jongro07BusListView()
            }
            
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    HSSCRefreshButton(busType: .Jonro07Bus)
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
    Jongro07BusMainView()
}
