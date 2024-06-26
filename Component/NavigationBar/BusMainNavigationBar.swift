//
//  BusMainNavigationBar.swift
//  skkumap
//
//  Created by 조승용 on 2024/01/02.
//

import SwiftUI

struct BusMainNavigationBar: View {
    let title: String
    let backgroundColor: Color
    let isDisplayLeftBtn: Bool
    let isDisplayRightBtn: Bool
    let leftBtnAction: () -> Void
    let RightBtnAction: () -> Void
    let RightBtnType: BusMainBtnType
    
    init(
        title: String = "testtitle",
        backgroundColor: Color = CustomColor.deepgreen,
        isDisplayLeftBtn: Bool = true,
        isDisplayRightBtn: Bool = true,
        leftBtnAction: @escaping () -> Void = {},
        RightBtnAction: @escaping () -> Void = {},
        RightBtnType: BusMainBtnType = .info
        
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisplayRightBtn = isDisplayRightBtn
        self.leftBtnAction = leftBtnAction
        self.RightBtnAction = RightBtnAction
        self.RightBtnType = RightBtnType
    }
    
    
    
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(backgroundColor)
                .frame(width: UIScreen.screenWidth, height: 50)
            HStack(alignment: .center){
                
                
                if isDisplayLeftBtn {
                    Button(action: leftBtnAction) {
                        Image(systemName: "chevron.backward")
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                    }
                } else {
                    Spacer()
                        .frame(width: 15, height: 15)
                }
                
                
                Spacer()
                
                
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color.white)
                
                
                Spacer()
                
                if isDisplayRightBtn {
                    Button(action: RightBtnAction) {
                        switch RightBtnType {
                        case .close:
                            Image(systemName: "xmark.circle")
                                .frame(width: 15, height: 15)
                                .foregroundColor(.white)
                        case .info:
                            Image(systemName: "info.circle")
                                .frame(width: 15, height: 15)
                                .foregroundColor(.white)
                        case .help:
                            Image(systemName: "questionmark.circle")
                                .frame(width: 15, height: 15)
                                .foregroundColor(.white)
                        }
                    }
                    
                } else {
                    Spacer()
                        .frame(width: 15, height: 15)
                }
               
                
                
            }
            .padding(.horizontal, 15)
            
        }
        .frame(width: UIScreen.screenWidth, height: 43)
    }
}

#Preview {
    BusMainNavigationBar(title: "testtitle", backgroundColor: CustomColor.deepgreen, isDisplayLeftBtn: true, isDisplayRightBtn: true, leftBtnAction: {}, RightBtnAction: {}, RightBtnType: .info)
}
