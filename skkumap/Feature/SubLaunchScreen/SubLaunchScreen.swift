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
//            Spacer()
//                .frame(height: 250)
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
                    .frame(height: UIScreen.main.bounds.height * 1.2) // Extend the height a bit more to avoid the black line
                    .offset(y: animateGradient ? 50 : -UIScreen.main.bounds.height * 1.2) // Start above the screen and animate down to 0
                    .animation(Animation.easeInOut(duration: 1.3), value: animateGradient)
                    .onAppear {
                        animateGradient = true
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                            withAnimation(Animation.easeInOut(duration: 1.5)) {
//                                animateGradient = false
//                            }
//                        }
                    }
            }
        }
    }
}

#Preview {
    SubLaunchScreen()
}
