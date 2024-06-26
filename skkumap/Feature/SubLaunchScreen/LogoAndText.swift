//
//  LogoAndText.swift
//  skkumap
//
//  Created by 조승용 on 6/26/24.
//

import SwiftUI

struct LogoAndTextView: View {
    var body: some View {
            HStack {
                Spacer()
                VStack(spacing: 0) {
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
        }
}

#Preview {
    LogoAndTextView()
}
