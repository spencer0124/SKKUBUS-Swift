    //
    //  MapView.swift
    //  skkumap
    //
    //  Created by 조승용 on 2023/12/21.
    //


import SwiftUI
import NMapsMap
import ActivityKit
import FirebaseFirestore

enum Route {
    case link1, link2
}

struct MapView: View {
    // 전체 path 관리
    @Binding var path: NavigationPath
    
    
    
    
    @StateObject var coordinator: Coordinator = Coordinator.shared
    
    // 하단 메뉴바 3개 중에 고르는거
    // 페이지 내부에서 변하는거지, 페이지 외부랑은 상관없음
    @State private var currentPage: Int = 1
    
    
    
    
    
    // MARK: - Properties
    @State private var currentOffset: CGFloat = 0
    @State private var sheetPosition: SheetPosition = .mid
    
    //    private var screenHeight: CGFloat {
    //        UIScreen.main.bounds.height
    //    }
    
   
    
    // MARK: - Body
    
    @State private var selectedType: Int? = nil
    
    struct IconData {
        var showBorder: Bool
        var showArrow: Bool
        var imageName: String
        var imageType: SearchIcon.ImageType
        var iconColor: Color
        var text: String
        var url: URL?
        var type: Int
    }
    
    let iconDataArray: [IconData] = [
        IconData(showBorder: true, showArrow: true, imageName: "subway", imageType: .photo, iconColor: .black, text: "건물지도", url: URL(string: "https://www.example.com"), type: 1),
        IconData(showBorder: false, showArrow: false, imageName: "map", imageType: .icon, iconColor: .black, text: "캠퍼스지도", url: URL(string: "https://www.example.com"), type: 2),
        IconData(showBorder: false, showArrow: false, imageName: "person.text.rectangle", imageType: .icon, iconColor: .black, text: "음식점", url: URL(string: "https://www.example.com"), type: 1),
        IconData(showBorder: false, showArrow: false, imageName: "bag", imageType: .icon, iconColor: .black, text: "분실물", url: URL(string: "https://www.example.com"), type: 1)
    ]
    
    var body: some View {
            ZStack {
                NaverMap().ignoresSafeArea()
                VStack(alignment: .leading){
                    Color.clear
                        .frame(width: 6, height: 2)
                    SearchView()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 5) {
                            Color.clear.frame(width: 10, height: 30)
                            ForEach(iconDataArray, id: \.text) { data in
                                Button(action: {
                                    print("path append: " + data.text)
                                    path.append(NavigationState.webviewBuilding)
                                    print(path)
                                }) {
                                    SearchIcon(
                                        showBorder: data.showBorder,
                                        showArrow: data.showArrow,
                                        imageName: data.imageName,
                                        imageType: data.imageType,
                                        iconColor: data.iconColor,
                                        text: data.text,
                                        url: data.url
                                    )
                                    .contentShape(Rectangle()) // Ensure entire area is tappable
                                }
                                .buttonStyle(PlainButtonStyle()) // Remove any default button styling
                            }
                        }
                    }
                    .onTapGesture {
                        // Button 클릭이 간헐적으로 무시되는 문제
                        // ScrollView에 empty onTapGesture를 추가하여 해결
                    }
                    Spacer()
                }
                DraggableView(currentPage: $currentPage, sheetPosition: $sheetPosition, currentOffset: $currentOffset, path: $path)
                //                .offset(y: calculateOffset() + currentOffset)
                //                .gesture(dragGesture())
                CustomNavigationBar(selectedPage: $currentPage)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 95 )
            }


            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                print("current path!: ")
                print(path)
                Coordinator.shared.checkIfLocationServiceIsEnabled()
//                if(deepLinkText.isEmpty) {
//                    print("movedeeplink1 is false")
//                    
//                } else {
//                    print("movedeeplink1 is true")
//                    path.append("campubus")
//                }
            }
           

       
    }
        
}
    

#Preview {
    MapView(path: .constant(NavigationPath()))
}
