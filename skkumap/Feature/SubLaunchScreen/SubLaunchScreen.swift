//
//  SubLaunchScreen.swift
//  skkumap
//
//  Created by 조승용 on 2024/05/17.
//

import SwiftUI

struct SubLaunchScreen: View {
    @Binding var path: NavigationPath
    @State private var animateGradient: Bool = false // 애니메이션 관리
    @Binding var CampbusMainDeep: Bool // Deeplink에 따른 Path 분기처리
    
    var body: some View {
            VStack {
                Spacer()
                LogoAndTextView()
                Spacer()
            }
            .background {
                GradientAnimationView(animateGradient: $animateGradient)
            }
            .onAppear {
                startGradientAnimation()
            }
    }
    
    
    func startGradientAnimation() {
            // 이걸로 감싸주지 않으면 애니메이션이 left top에서 시작됨
            DispatchQueue.main.async {
                animateGradient = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                UIView.setAnimationsEnabled(false)
                
                // 페이지 이동
                path.append(NavigationState.MapView)
                
                // DeepLink 처리
                if(CampbusMainDeep) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            path.append(NavigationState.campusBus)
                        }
                    }
                }
                
                // 위에서 false 했다가 다시 true로 바꿔주기 (ui 버그 수정)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    UIView.setAnimationsEnabled(true)
                }
            }
        }
    
    
}

#Preview {
    SubLaunchScreen(path: .constant(NavigationPath()), CampbusMainDeep: .constant(false))
}
