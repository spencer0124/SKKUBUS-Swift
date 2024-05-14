//
//  NetworkAlertBanner.swift
//  skkumap
//
//  Created by 조승용 on 2024/05/15.
//

import SwiftUI

struct NetworkAlertBanner: View {
    @Binding var isConnected: Bool 
    @State private var showAlert = false
    

    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "exclamationmark.icloud")
                        .foregroundColor(.white)
                    Text("네트워크 연결을 확인해주세요")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                }
                .frame(height: 50)
                .background(Color.gray)
                .offset(y: showAlert ? 0 : -150)
                .animation(.easeInOut, value: showAlert)
                Spacer()
            }
            .onAppear {
                showAlert = !isConnected
            }
            .onChange(of: isConnected) { connected in
                showAlert = true

                if connected {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            showAlert = false
                        }
                    }
                }
            }
        }
    }
//
//#Preview {
//    @StateObject var networkMonitor = NetworkMonitor()
//
//    NetworkAlertBanner()
//}
