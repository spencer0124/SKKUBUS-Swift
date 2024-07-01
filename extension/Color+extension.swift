//
//  ColorExtension.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

import Foundation
import SwiftUI


extension UIColor {
    convenience init(_ color: Color) {
        let components = color.cgColor?.components
        let red = components?[0] ?? 0.0
        let green = components?[1] ?? 0.0
        let blue = components?[2] ?? 0.0
        let alpha = components?.count ?? 0 > 3 ? components?[3] ?? 1.0 : 1.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}


struct CustomColor {
    static let deepgreen = Color("DeepGreen1")
    static let gradientGreen1 = Color("GradientGreen1")
    static let gradientGreen2 = Color("GradientGreen2")
    static let displayGreen1 = Color("DisplayGreen1")
    static let displayGray1 = Color("DisplayGray1")
}
