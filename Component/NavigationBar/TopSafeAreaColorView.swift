//
//  TopSafeAreaColorView.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

import SwiftUI

struct TopSafeAreaColorView: View {
    var body: some View {
        GeometryReader { reader in
            Color.green
                .frame(height: reader.safeAreaInsets.top, alignment: .top)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    TopSafeAreaColorView()
}
