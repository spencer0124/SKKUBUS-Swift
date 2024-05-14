//
//  Constants.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/23.
//

import Foundation
import SwiftUI


struct APIConstants {
    static let JongroBusHewaStation = "http://ws.bus.go.kr/api/rest/arrive/getArrInfoByRoute?ServiceKey=ORCkFmKr8bIoQOxjPIhZsu4xEumjEQFC9cFW%2Br6C026Yk2LMhxAsuEb%2BYVShmoMzD8HHW257I92FA8slrJUQMg%3D%3D&stId=100900075&busRouteId=100900004&ord=12&resultType=json"
    
    
    static let BusBasic = "ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com" 
}


struct BusConstants {
    static let BusMainLeftSpace = UIScreen.screenWidth * 0.18 + 10
}
