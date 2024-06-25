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

@main
struct skkumapApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var movedeeplinktext: String = ""
    @State private var test : String = "hi"
    
    var body: some Scene {
        WindowGroup {
//                SubLaunchScreen()
                MapView(argument: $test)
                .environment(\.deepLinkText, movedeeplinktext)
                .onOpenURL(perform: { url in

                    movedeeplinktext = url.absoluteString.removingPercentEncoding ?? ""
                    
                       
                    
                })
//            Webview_building()
//            MapView()
//            Jongro07BusMainView()
        }
    }
}

struct DeepLinkEnv: EnvironmentKey {
  static let defaultValue = ""
}

extension EnvironmentValues {
  var deepLinkText: String {
    get { self[DeepLinkEnv.self] }
    set { self[DeepLinkEnv.self] = newValue }
  }
}
