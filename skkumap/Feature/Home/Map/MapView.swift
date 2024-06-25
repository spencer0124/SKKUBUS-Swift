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
    @State private var path = NavigationPath()
    
    
    @Binding var argument: String
    @Environment(\.deepLinkText) var deepLinkText: String
    
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
    
    // 상단 버튼 클릭했을때 이동하는거 관리
    @State private var moveToViewA:Bool = false
    @State private var moveToViewB:Bool = false
    @State private var moveToViewC:Bool = false
    @State private var moveToHSSCBus:Bool = false
    @State private var moveToCampusBus:Bool = false
    @State private var moveToJongro07Bus:Bool = false
    
    
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
        
        NavigationStack(path: $path) {
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
                                    path.append(data.text)
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
                DraggableView(currentPage: $currentPage, sheetPosition: $sheetPosition, currentOffset: $currentOffset, moveToHSSCBus: $moveToHSSCBus, moveToCampusBus: $moveToCampusBus, moveToJongro07Bus: $moveToJongro07Bus)
                //                .offset(y: calculateOffset() + currentOffset)
                //                .gesture(dragGesture())
                CustomNavigationBar(selectedPage: $currentPage)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 95 ) // Adjust position as needed
            }
//            .navigationDestination(isPresented: $moveToViewA, destination: {Webview_building().navigationBarBackButtonHidden(false)})
//            .navigationDestination(isPresented: $moveToViewB, destination: {Webview_building().navigationBarBackButtonHidden(false)})
//            .navigationDestination(isPresented: $moveToViewC, destination: {Webview_building().navigationBarBackButtonHidden(false)})
//            .navigationDestination(isPresented: $moveToHSSCBus, destination: { MainBusMainView(busType: BusType.HSSCBus).navigationBarBackButtonHidden(true)})
//            .navigationDestination(isPresented: $moveToCampusBus, destination: { MainBusMainView(busType: BusType.CampusBus).navigationBarBackButtonHidden(true)})
//            .navigationDestination(isPresented: $moveToJongro07Bus, destination: { MainBusMainView(busType: BusType.Jongro07Bus).navigationBarBackButtonHidden(true)})
            .navigationDestination(for: String.self) { route in
                switch route {
                case "건물지도":
                    Webview_building(path: $path).navigationBarBackButtonHidden(true)
                case "캠퍼스지도":
                    CampusBusView().navigationBarBackButtonHidden(true)
                case "campusbus":
                    CampusBusView().navigationBarBackButtonHidden(true)
                default:
                    Webview_building(path: $path).navigationBarBackButtonHidden(true)
                }
            }

            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                Coordinator.shared.checkIfLocationServiceIsEnabled()
                if(deepLinkText.isEmpty) {
                    print("movedeeplink1 is false")
                    
                } else {
                    print("movedeeplink1 is true")
                    path.append("campubus")
                }
            }
           
        }
       
    }
        
//    
//    private func handleButtonClick(type: Int) {
//           switch type {
//           case 1:
//               moveToViewA = true
//           case 2:
//               moveToViewB = true
//           default:
//               moveToViewC = true
//           }
//       }
    
   
}
    

#Preview {
    MapView(argument: .constant("hi"))
}
