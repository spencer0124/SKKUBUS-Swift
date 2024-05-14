import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    var isConnected: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        if isConnected, let url = URL(string: viewModel.urlToLoad), url.absoluteString != uiView.url?.absoluteString {
                    let request = URLRequest(url: url)
                    uiView.load(request)
                }
    }
}

struct Webview_building: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedOption = "인사캠"
    let options = ["인사캠", "자과캠"]
    @ObservedObject var webViewModel = WebViewModel(initialURL: "https://skkubus-webview.vercel.app/#/map/hssc")
    @StateObject private var networkMonitor = NetworkMonitor()
   
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("성균관대 건물지도")
                        .font(.headline)
                        .foregroundStyle(Color(.white))
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color(.customDeepGreen1))
                .frame(height: 45)
                
                Spacer().frame(height: 13)
                
                Picker("Options", selection: $selectedOption) {
                    ForEach(options, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 10)
                .background(Color.white)
                .onChange(of: selectedOption) { newValue in
                    webViewModel.updateURL(for: newValue)
                }
                
                Spacer().frame(height: 13)
                
               
                WebView(viewModel: webViewModel, isConnected: networkMonitor.isConnected)
                                    .edgesIgnoringSafeArea(.bottom)
                    
                    
                
                
                
            }
            
            
            NetworkAlertBanner(isConnected: $networkMonitor.isConnected)
           
                    }
                }
    
    func determineURL(for option: String) -> String {
        if option == "인사캠" {
            return "https://skkubus-webview.vercel.app/#/map/hssc"
        } else {
            return "https://skkubus-webview.vercel.app/#/map/nsc"
        }
    }
}

#Preview {
    Webview_building()
}
