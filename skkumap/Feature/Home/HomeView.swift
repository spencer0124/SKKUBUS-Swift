//
//  HomeView.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/21.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("홈")
                .tabItem {
                    
                    Image(systemName: "house.fill")
                    Text("홈")
                }
                .tag(0)
            
            Text("학생회")
                .tabItem {
                    
                    Image(systemName: "graduationcap")
                    Text("학생회")
                }
                .tag(1)
            
            Text("게시판")
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("게시판")
                }
                .tag(2)
            
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("지도")
                }
                .tag(3)
            
            Text("설정")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("설정")
                }
                .tag(4)
        }
    }
}

#Preview {
    HomeView()
}
