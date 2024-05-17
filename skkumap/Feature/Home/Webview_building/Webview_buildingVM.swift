// Webview_buildingVM.swift
// skkumap
// Created by 조승용 on 2024/05/14.

import Foundation
import Combine

class WebViewModel: ObservableObject {
    @Published var urlToLoad: String
    private var lastLoadedURL: String?
    private var cancellables: Set<AnyCancellable> = []
    
    init(initialURL: String) {
        self.urlToLoad = initialURL
        self.lastLoadedURL = initialURL
    }
    
    func updateURL(for option: String) {
        
        switch option {
        case "인사캠" :
            urlToLoad = WebviewBuildingURLs.hssc
        case "자과캠" :
            urlToLoad = WebviewBuildingURLs.nsc
        default:
            break
        }
        reloadPageIfNeeded()
    }
    
    private func reloadPageIfNeeded() {
          if urlToLoad != lastLoadedURL {
              lastLoadedURL = urlToLoad
              objectWillChange.send()
          }
      }
}
