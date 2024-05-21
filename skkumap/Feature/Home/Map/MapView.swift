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


struct MapView: View {
    @Binding var argument: String
    
    
    @StateObject var coordinator: Coordinator = Coordinator.shared
    
    // 하단 메뉴바 3개 중에 고르는거
    // 페이지 내부에서 변하는거지, 페이지 외부랑은 상관없음
    @State private var currentPage: Int = 1
    // navigationstack 이용해서 이동하기 위해 사용하는거
    
   
    
    // MARK: - Properties
    @State private var currentOffset: CGFloat = 0
    @State private var sheetPosition: SheetPosition = .mid
    
    //    private var screenHeight: CGFloat {
    //        UIScreen.main.bounds.height
    //    }
    
    
    
    // MARK: - Body
    
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
        IconData(showBorder: false, showArrow: false, imageName: "person.text.rectangle", imageType: .icon, iconColor: .black, text: "킹고패스", url: URL(string: "https://www.example.com"), type: 3),
        IconData(showBorder: false, showArrow: false, imageName: "bag", imageType: .icon, iconColor: .black, text: "분실물", url: URL(string: "https://www.example.com"), type: 4)
    ]


    
    var body: some View {
        NavigationStack {
        ZStack {
            NaverMap().ignoresSafeArea()
            VStack(alignment: .leading){
                Color.clear
                    .frame(width: 6, height: 2)
                SearchView()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 5) {
                        Color.clear.frame(width: 10, height: 30)
                        // 기본 spacing이 10이기 때문에 15-5=10만큼만 width 주면 된다
                        
                        
                        SearchIcon(showBorder: true, showArrow: true, imageName: "subway", imageType: .photo, iconColor: .black, text: "건물지도", url: URL(string: "https://www.example.com"))
                            .navigationDestination(isPresented: .constant(false), destination: {Webview_building().navigationBarBackButtonHidden(true)})
                                      
                        
                        
                        SearchIcon(showBorder: false, imageName: "map", imageType: .icon, iconColor: .black, text: "캠퍼스지도", url: URL(string: "https://www.example.com") )
                        
                        SearchIcon(showBorder: false, imageName: "person.text.rectangle", imageType: .icon, iconColor: .black, text: "킹고패스", url: URL(string: "https://www.example.com"))
                        
                        SearchIcon(showBorder: false, imageName: "bag", imageType: .icon, iconColor: .black, text: "분실물", url: URL(string: "https://www.example.com") )
                    }
                }
                //                SearchIconsView()
                Spacer()
            }
            DraggableView(currentPage: $currentPage, sheetPosition: $sheetPosition, currentOffset: $currentOffset)
            //                .offset(y: calculateOffset() + currentOffset)
            //                .gesture(dragGesture())
            CustomNavigationBar(selectedPage: $currentPage)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 95 ) // Adjust position as needed
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            Coordinator.shared.checkIfLocationServiceIsEnabled()
        }
        
    }
    }
        
}



    // MARK: - preview
    #Preview {
        MapView(argument: .constant("hi"))
    }
