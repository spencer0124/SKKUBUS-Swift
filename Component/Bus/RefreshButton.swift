//
//  HSSCRefreshButton.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

import SwiftUI
import Lottie

struct HSSCRefreshButton: View {
    
    @StateObject var HSSCBusComponentViewModel = HSSCBusComponentVM()
    
    @State private var playbackMode: LottiePlaybackMode = .paused
    @State private var timer = Timer.publish(every: 15, on: .main, in:.common).autoconnect()
    
    let busType: BusType
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.gray)
                .frame(width: 48, height: 48)
            LottieView(animation: .named("refresh_white"))
                .playbackMode(playbackMode)
                .animationDidFinish { _ in
                        playbackMode = .paused
                      }
                .frame(width: 42, height: 42)
                .padding(.leading, 2.0)
        }
        .clipShape(Circle())
        .contentShape(Circle())
        // 얘는 어차피 앱이 켜지면 active 감지 -> 새로고침 하기 때문에 또 실행시켜줄 필요가 없다
//        .onAppear() {
//            refreshAction()
//        }
        .onTapGesture {
            print("onTapGesture clicked")
            userDidTap()
        }
        .onReceive(timer) { _ in
                refreshAction()
        }
    }
    
    private func userDidTap() {
        resetTimer()
        refreshAction()
    }
    
    private func refreshAction() {
        
        playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .playOnce))
        
        switch busType {
        case .Jonro07Bus:
            print("Jonro07Bus")
            HSSCBusComponentViewModel.refreshBusStations()
        case .HSSCBus:
            print("HSSCBus")
            // actual implementation here
        case .CampusBus:
            print("CampusBus")
            // actual implementation here
        }
        
        print("data fetch done - main")
    }
    
    private func resetTimer() {
        timer.upstream.connect().cancel()
        timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    }
}



#Preview {
    HSSCRefreshButton(busType: .Jonro07Bus)
}
