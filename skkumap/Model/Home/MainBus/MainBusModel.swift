//
//  Jongro07BusModel.swift
//  skkumap
//
//  Created by 조승용 on 2024/01/03.
//

import Foundation
//
//struct Jongro07BusStationInfo : Decodable {
//    let stationId: Int
//    let name: String
//    let StationMessage: String
//    let isFirstStation: Bool
//    let isLastStation: Bool
//    let isRotationStation: Bool
//    let iscurrentBusLocated: Bool
//    let exceedSecond: Int?
//    let carnumber: String?
//}


struct MainBusStation {
    var internalStationId: Int
    var stationName: String
    var externalStationId: String
    var eta: String?
    var isFirstStation: Bool
    var isLastStation: Bool
    var isRotationStation: Bool
}



