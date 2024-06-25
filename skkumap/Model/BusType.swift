//
//  BusType.swift
//  skkumap
//
//  Created by 조승용 on 2024/01/03.
//

import Foundation
import SwiftUI

enum BusType {
    case HSSCBus
    case CampusBus
    case Jongro02Bus
    case Jongro07Bus
    case Jongro08Bus
    
    func getBusTitle() -> String {
            switch self {
            case .HSSCBus:
                return "인사캠 셔틀"
            case .CampusBus:
                return "인자셔틀"
            case .Jongro02Bus:
                return "종로02"
            case .Jongro07Bus:
                return "종로07"
            case .Jongro08Bus:
                return "종로08"
            }
    
        }
        
        func getBusColor() -> Color {
            switch self {
            case .HSSCBus:
                return Color(hex: 0xFF003626)
            case .CampusBus:
                return Color(hex: 0xFF003626)
            case .Jongro02Bus, .Jongro07Bus, .Jongro08Bus:
                return Color(hex: 0xFF53b332)
            }
        }
    
}
