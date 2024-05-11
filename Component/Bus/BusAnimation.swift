//
//  HSSCBusAnimation.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

import SwiftUI

struct HSSCBusAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
            ZStack {
                Circle()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.green)
                    .scaleEffect(isAnimating ? 1.75 : 1.0)
                    .opacity(isAnimating ? 0 : 1)
                    // Animation with infinite repeat
                    .animation(.easeOut(duration: 1.9).repeatForever(autoreverses: false), value: isAnimating)

                Circle()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.green)
                
                Image(systemName: "bus.fill")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
            }
//            .padding(.leading, UIScreen.main.bounds.size.width * 0.1735)
            .onAppear {
                isAnimating = true
            }
        }
    }

#Preview {
    HSSCBusAnimation()
}
