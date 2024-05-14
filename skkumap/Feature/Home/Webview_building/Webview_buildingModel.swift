// Webview_buildingModel.swift
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
        if option == "인사캠" {
            urlToLoad = "https://skkubus-webview.vercel.app/#/map/hssc"
        } else {
            urlToLoad = "https://skkubus-webview.vercel.app/#/map/nsc"
        }
        reloadPageIfNeeded()
    }
    
    func reloadPage() {
        // Trigger a reload by updating the URL
        lastLoadedURL = nil
        reloadPageIfNeeded()
    }
    
    private func reloadPageIfNeeded() {
          if urlToLoad != lastLoadedURL {
              lastLoadedURL = urlToLoad
              // Notify the WebView to reload
              objectWillChange.send()
          }
      }
}
