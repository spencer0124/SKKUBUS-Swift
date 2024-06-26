//
//  skkumapApp.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/21.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        let settings = Firestore.firestore().settings
        
        // 아래 settings. ...으로 시작하는 세 줄을 주석 처리하면, 실제 서버와 작업
        // local emulator로 작업하기 위한 작업
        settings.host = "127.0.0.1:8080"
        settings.cacheSettings = MemoryCacheSettings()
        settings.isSSLEnabled = false
        //
        Firestore.firestore().settings = settings
        
        return true
    }
}

class AppState {
  static let shared = AppState()

  var swipeEnabled = true    // << by default
}






enum NavigationState {
    case webviewBuilding,campusMap,campusBus, HSSCBus, Jongro07Bus, MapView
}


@main
struct skkumapApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var path = NavigationPath()
    @State var CampbusMainDeep: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                VStack {
                    SubLaunchScreen(path: $path, CampbusMainDeep: $CampbusMainDeep)
                        .onOpenURL(perform: { url in
                            CampbusMainDeep = true
                        })
//                    MapView(path: $path)
                }
                .navigationDestination(for: NavigationState.self) { route in
                    switch route {
                        case .webviewBuilding:
                            Webview_building(path: $path).navigationBarBackButtonHidden(true)
                        case .campusMap:
                            CampusBusView(path: $path).navigationBarBackButtonHidden(true)
                        case .campusBus:
                            CampusBusView(path: $path).navigationBarBackButtonHidden(true)
                        case .HSSCBus:
                            MainBusMainView(busType: .HSSCBus).navigationBarBackButtonHidden(true)
                        case .Jongro07Bus:
                            MainBusMainView(busType: .Jongro07Bus).navigationBarBackButtonHidden(true)
                        case .MapView:
                            MapView(path: $path).navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
    }
}
