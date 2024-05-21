//
//  SearchView.swift
//  skkumap
//
//  Created by 조승용 on 2024/05/17.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(height: 50)
                .cornerRadius(10)
                .padding(.horizontal, 15)
                .shadow(color: .gray, radius: 60, x: 8, y: 8)
                
            HStack(spacing: 12){
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(width: 20, height: 20)
                    .padding(.leading, 15+15)
                Text("성균관대 공간명/코드 검색")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                Spacer()
            }
        }
    }
}

#Preview {
    SearchView()
}
