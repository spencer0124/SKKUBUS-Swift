//
//  TopSafeAreaColorView.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

// top safearea 색 지정해주는 코드
// 기본값은 .customDeepGreen1j
// 직접 color: .green 처럼 설정해주는 것도 가능

import SwiftUI

struct TopSafeAreaColorView: View {
    var color: Color = CustomColor.deepgreen
    
    
    var body: some View {
        GeometryReader { reader in
            color
                .frame(height: reader.safeAreaInsets.top, alignment: .top)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    TopSafeAreaColorView(color: CustomColor.deepgreen)
}
