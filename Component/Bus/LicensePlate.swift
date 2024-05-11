//
//  LicensePlate.swift
//  skkumap
//
//  Created by 조승용 on 2024/01/03.
//

import SwiftUI

struct LicensePlate: View {
    var body: some View {
        ZStack {
            Text("74거 9957")
                .font(.system(size: 8, weight: .medium))
                .padding(.trailing, 2)
                .foregroundColor(.gray)
            Image("LicensePlate")
                .resizable()
                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                .foregroundColor(.gray)
                
                .frame(width: 55, height: 18)
        }
        
    }
        
}

#Preview {
    LicensePlate()
}
