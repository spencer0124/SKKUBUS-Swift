//
//  SearchIcon.swift
//  skkumap
//
//  Created by 조승용 on 2024/05/17.
//


import SwiftUI

struct SearchIcon: View {
    var showBorder: Bool = true
    var showArrow: Bool = false
    var imageName: String = "subway"
    var imageType: ImageType = .icon
    var iconColor: Color = .black
    var text: String = "캠퍼스맵"
    var url: URL? = nil
    
    
    
    enum ImageType {
        case photo
        case icon
    }

    var body: some View {
        
//        NavigationStack {
            
            
            HStack(spacing: 0) {
                if showBorder {
                    imageElement
                        .frame(width: 24, height: 24)
                        .overlay(Circle().stroke(Color.black.opacity(0.3), lineWidth: 0.5))
                        .padding(-0.5)
                    Color.clear.frame(width: 6, height: 32)
                }
                if !showBorder {
                    Color.clear.frame(width: 1.5, height: 32)
                    imageElement
                        .frame(width: 24, height: 24)
                    Color.clear.frame(width: 2, height: 32)
                }
                Text(text)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                
                if showArrow {
                    Color.clear.frame(width: 3.5, height: 32)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.gray)
                    Color.clear.frame(width: 4, height: 32)
                }
                if !showArrow {
                    Color.clear.frame(width: 6, height: 32)
                }
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 1)
            .background(
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(200)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            )
            //            .onTapGesture {
            //                        // When the icon is tapped, set the path value
            //                        path = [pathValue]
            //                
            //                    }
            //            .onTapGesture {
            //                if let url = url {
            //                    UIApplication.shared.open(url)
            //                }
            //            }
        
        
    }
    
    @ViewBuilder
    private var imageElement: some View {
        switch imageType {
        case .photo:
            Image(imageName)
                .resizable()
        case .icon:
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(iconColor)
        }
    }
}
//
//#Preview {
//    SearchIcon(showBorder: true, showArrow: true, imageName: "subway", imageType: .photo, iconColor: .black, text: "건물지도", url: URL(string: "https://www.example.com"), path: $path, pathValue: 32)
//}
