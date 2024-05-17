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
    @ObservedObject var webViewModel = WebViewModel(initialURL: WebviewBuildingURLs.hssc)
    
    // @StateObject ensures that the object’s lifecycle is tied to the lifecycle of the view and that it’s only created once.
    @StateObject private var networkMonitor = NetworkMonitor()

    var body: some View {
        ZStack {
            VStack {
                headerView
                Spacer().frame(height: 13)
                optionPicker
                Spacer().frame(height: 13)
                webView
            }
            NetworkAlertBanner(isConnected: $networkMonitor.isConnected)
        }
    }

    private var headerView: some View {
        HStack {
            backButton
            Spacer()
            title
            Spacer()
            infoButton
        }
        .padding()
        .background(Color.customDeepGreen1)
        .frame(height: 45)
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
        }
    }

    private var title: some View {
        Text("성균관대 건물지도")
            .font(.headline)
            .foregroundColor(.white)
    }

    private var infoButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "info.circle")
                .foregroundColor(.white)
        }
    }

    private var optionPicker: some View {
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
    }

    private var webView: some View {
        WebView(viewModel: webViewModel, isConnected: networkMonitor.isConnected)
            .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    Webview_building()
}
