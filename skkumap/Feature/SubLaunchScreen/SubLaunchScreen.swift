//
//  SubLaunchScreen.swift
//  skkumap
//
//  Created by 조승용 on 2024/05/17.
//

import SwiftUI


extension Color {
    static let green1 = Color(hex: 0x3de010)
    static let green2 = Color(hex: 0x2d7d6c)
}

struct SubLaunchScreen: View {
    
    @Binding var path: NavigationPath
    @State private var animateGradient: Bool = false
    
    
    var body: some View {
        
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack(spacing:0) {
                        Image("skku_logo_black")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 150, height: 150)
                            .foregroundColor(.white)
                        
                        Image("skku_text")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(height: 50)
                            .foregroundColor(.white)
                        
                        
                        
                        Spacer()
                            .frame(height: 270)
                        
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            .background {
                ZStack {
                    Color.customDeepGreen1.edgesIgnoringSafeArea(.all)
                    
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    .green2.opacity(0.9),
                                    .green2.opacity(0.7),
                                    .green2.opacity(0.3),
                                    .green2.opacity(0.01),
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(height: UIScreen.main.bounds.height * 1.2)
                        .offset(y: animateGradient ? 50 : -UIScreen.main.bounds.height * 1.2)
                        .animation(Animation.easeInOut(duration: 1.3), value: animateGradient)
                        .onAppear {
                            
                            // 이걸로 감싸주지 않으면 Top left에서 애니메이션이 시작한다
                            DispatchQueue.main.async {
                                animateGradient = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                // 1.3s for animation + 0.5s delay
                                UIView.setAnimationsEnabled(false)
                                
                                
                                // 페이지 이동 코드 넣기
                                path.append(NavigationState.MapView)
                                
                                
                                // 위에서 false 했다가 다시 true로 바꿔주기 (ui 버그 수정)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    UIView.setAnimationsEnabled(true)
                                }
                                
                                
                            }
                        }
                }
            }
            
            
            
            
            
        
    }
}

#Preview {
    SubLaunchScreen(path: .constant(NavigationPath()))
}
