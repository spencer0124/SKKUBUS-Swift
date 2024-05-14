//
//  Map.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/23.
//

import Foundation

struct HomeWidgetStation {
    var stationName: String
    var bus1Name: String
    var bus1Status: String
    var bus2Name: String
    var bus2Status: String
    var Icon: String
    var link: URL
}

struct HomeWidgetBus {
    var busName: String
    var bustype: String
    var busInfo: String
    var mainIcon: String
    var link: URL
}


struct JonroBusHewaStation: Codable {
    
}

