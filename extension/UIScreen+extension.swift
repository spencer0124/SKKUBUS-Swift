//
//  UIScreenExtension.swift
//  skkumap
//
//  Created by 조승용 on 2024/01/02.
//

import Foundation
import SwiftUI

extension UIScreen{
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
}
