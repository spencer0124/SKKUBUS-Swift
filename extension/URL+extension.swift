//
//  URL+extension.swift
//  skkumap
//
//  Created by 조승용 on 2024/01/03.
//

import Foundation

extension URL {
    
    static func forJongroBusByNumber(_ busNumber: Int ) -> URL? {
        return URL(string: "\(APIConstants.BusBasic)/bus/jongro\(busNumber)")
    }
}
