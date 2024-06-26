//
//  GradientAnimation.swift
//  skkumap
//
//  Created by 조승용 on 6/26/24.
//

import SwiftUI

struct GradientAnimationView: View {
    @Binding var animateGradient: Bool

    var body: some View {
        ZStack {
            CustomColor.deepgreen.edgesIgnoringSafeArea(.all)
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            CustomColor.gradientGreen2.opacity(0.9),
                            CustomColor.gradientGreen2.opacity(0.7),
                            CustomColor.gradientGreen2.opacity(0.3),
                            CustomColor.gradientGreen2.opacity(0.01),
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: UIScreen.main.bounds.height * 1.2)
                .offset(y: animateGradient ? 50 : -UIScreen.main.bounds.height * 1.2)
                .animation(Animation.easeInOut(duration: 1.3), value: animateGradient)
        }
    }
}

struct GradientAnimationView_Previews: PreviewProvider {
    @State static var animateGradient = false
    
    static var previews: some View {
        GradientAnimationView(animateGradient: $animateGradient)
    }
}
