//
//  BusInfoRow.swift
//  skkumap
//
//  Created by 조승용 on 2024/05/17.
//

import SwiftUI

struct BusInfoRow: View {
    var iconName: String
    var mainTitle: String
    var subtitle: String
    var boxText: String
    var themeColor: Color

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Color.clear
                    .frame(width: 4, height: 35)
                Image(iconName)  // Dynamic icon name
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                    
                Color.clear
                    .frame(width: 4, height: 35)
                
                VStack(alignment: .leading, spacing: 5){
                    
                    HStack {
                        
                        Text(mainTitle)  // Main title text
                            .bold()
                            .font(.system(size: 14))

                        ZStack {
                            Rectangle()
                                .fill(themeColor)
                                .frame(width: 30, height: 17)
                                .cornerRadius(5)
                            Text(boxText)  // Dynamic box text
                                .bold()
                                .font(.system(size: 11))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text(subtitle)  // Subtitle text
                        .font(.system(size: 12))
                }
                Spacer()

                VStack {
                    HStack(alignment: .center, spacing: 6){
                        Text("상세정보")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 5, height: 8)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                        .frame(height: 22)
                }
               
                
                Color.clear
                    .frame(width: 10, height: 35)
            }
            .padding([.top, .leading, ])
            
            Spacer()
                .frame(height: 18)
            
            
            Divider()
                .padding(.leading, 60)
        }
    }
}

#Preview {
    BusInfoRow(iconName: "bus", mainTitle: "Main Title", subtitle: "Subtitle", boxText: "Box", themeColor: .blue)
}
