//
//  BottomAdView.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

import SwiftUI

struct BottomAdView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.init(hex: 0xFFE8E9EB))
            //                .fill(Color.red)
                .frame(width: UIScreen.main.bounds.size.width, height: 50)
            Text("하단 배너 광고 영역")
        }
    }
}

#Preview {
    BottomAdView()
}
