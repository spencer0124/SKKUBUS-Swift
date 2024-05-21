//
//  CustomNavigationBar.swift
//  skkumap
//
//  Created by 조승용 on 2024/05/17.
//

import SwiftUI

struct CustomNavigationBar: View {
    @Binding var selectedPage: Int

    var body: some View {
        HStack {
            Spacer()

            Button(action: {
                selectedPage = 1
            }) {
                VStack {
                    Image(systemName: "bus.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(selectedPage == 1 ? Color.black : Color.gray)
                    Text("버스")
                        .bold()
                        .foregroundColor(selectedPage == 1 ? Color.black : Color.gray)
                        .font(.system(size: 12))
                    Color.clear.frame(width: 6, height: 18)
                }
            }

            Spacer()

            Button(action: {
                selectedPage = 2
            }) {
                VStack {
                    Image(systemName: "location.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(selectedPage == 2 ? Color.black : Color.gray)
                    Text("정류장")
                        .bold()
                        .foregroundColor(selectedPage == 2 ? Color.black : Color.gray)
                        .font(.system(size: 12))
                    Color.clear.frame(width: 6, height: 18)
                }
            }

            Spacer()

            Button(action: {
                selectedPage = 3
            }) {
                VStack {
                    Image(systemName: "graduationcap")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(selectedPage == 3 ? Color.black : Color.gray)
                    Text("캠퍼스")
                        .bold()
                        .foregroundColor(selectedPage == 3 ? Color.black : Color.gray)
                        .font(.system(size: 12))
                    Color.clear.frame(width: 6, height: 18)
                }
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(0)
        .shadow(radius: 4)
    }
}

//
//#Preview {
//    CustomNavigationBar()
//}
