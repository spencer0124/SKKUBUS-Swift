//
//  CampusBusView.swift
//  skkumap
//
//  Created by 조승용 on 6/24/24.
//

import SwiftUI

struct CampusBusView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    @Binding var path: NavigationPath
    
    var body: some View {
        
        ZStack(alignment: .top) {
            TopSafeAreaColorView(color: BusType.CampusBus.getBusColor())
            
            
            VStack(spacing:0) {
                BusMainNavigationBar(
                    title: BusType.CampusBus.getBusTitle(),
                    backgroundColor: BusType.CampusBus.getBusColor(),
                    isDisplayLeftBtn: true,
                    isDisplayRightBtn: true,
                    leftBtnAction:  {
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    RightBtnAction: {},
                    RightBtnType: .info
                )
                
                
            }
            
           
        }
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: nil) {
            BottomAdView()
                .frame(maxWidth: .infinity)
                .background(Color.init(hex: 0xFFE8E9EB))
        }
        
            
                
        
      
        
        
        
        
    }
}

#Preview {
    CampusBusView(
        path: .constant(NavigationPath())
    )
}
