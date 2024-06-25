//
//  CampusBusView.swift
//  skkumap
//
//  Created by 조승용 on 6/24/24.
//

import SwiftUI

struct CampusBusView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        
        Link(destination: URL(string: "skkubus://campusbus/main")!) {
            BusMainNavigationBar(
                title: "인자셔틀",
                backgroundColor: .customDeepGreen1,
                isDisplayLeftBtn: true,
                isDisplayRightBtn: true,
                leftBtnAction:  {
                    path.removeLast()
                },
                RightBtnAction: {},
                RightBtnType: .info
            )
            Text("Hello, World! campus bus")
                }
        
      
        
        
        
        
    }
}

#Preview {
    CampusBusView(
        path: .constant(NavigationPath())
    )
}
