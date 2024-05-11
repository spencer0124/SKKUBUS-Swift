//
//  HSSCBusComponentVM.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

import Foundation

class HSSCBusComponentVM: ObservableObject {
    @Published var stations: [HSSCBusStation] = [
        HSSCBusStation(name: "명륜새마을금고", number: "01504", eta: "정보 없음", isFirstStation: true, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "서울국제고등학교", number: "01512", eta: "1개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "국민생활관", number: "01521", eta: "2개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "혜화초등학교", number: "01532", eta: "도착 혹은 출발", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "혜화우체국", number: "01543", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "혜화역4번출구", number: "01876", eta: "도착 혹은 출발", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "혜화역.서울대병원입구", number: "01221", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "방송통신대앞.이화장", number: "01877", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: true),
        HSSCBusStation(name: "혜화역.마로니에공원", number: "01220", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "혜화역1번출구", number: "01592", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "혜화동로터리", number: "01226", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "성대입구", number: "01697", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "성균관대 정문", number: "01697", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "600주년 기념관", number: "01616", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "성균관대운동장", number: "01617", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "학생회관", number: "01618", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        HSSCBusStation(name: "성균관대학교", number: "01722", eta: "3개전", isFirstStation: false, isLastStation: true, isRotationStation: false)
    ]
    
    func refreshBusStations() {
        print("Jonro07 Bus data fetch done")
    }
}

struct HSSCBusStation {
    var name: String
    var number: String
    var eta: String
    var isFirstStation: Bool
    var isLastStation: Bool
    var isRotationStation: Bool
}
