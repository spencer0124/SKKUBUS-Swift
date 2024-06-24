//
//  Jongro07BusMainVM.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

import Foundation

class MainBusMainVM: ObservableObject {
    
//    @Published var stations: [Jongro07BusStationInfo] = []
//    
//    var httpClient = HTTPClient()
//    
//    func getStationsplease() {
//           httpClient.getJongro07station() { result in
//               switch result {
//               case .success(let stationInfos):
//                   DispatchQueue.main.async {
//                       self.stations = stationInfos
//                   }
//
//               case .failure(let error):
//                   print(error.localizedDescription)
//               }
//           }
//       }
   
    
    
    
    @Published var Jongro07stations: [MainBusStation] = [
        MainBusStation(internalStationId: 01504,stationName: "명륜새마을금고", externalStationId: "01504", eta: "정보 없음", isFirstStation: true, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01512,stationName: "서울국제고등학교", externalStationId: "01512", eta: "1개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01521,stationName: "국민생활관", externalStationId: "01521", eta: "2개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01532,stationName: "혜화초등학교", externalStationId: "01532", eta: "도착 혹은 출발", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01543,stationName: "혜화우체국", externalStationId: "01543", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01876,stationName: "혜화역4번출구", externalStationId: "01876", eta: "도착 혹은 출발", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01221,stationName: "혜화역.서울대병원입구", externalStationId: "01221", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01877,stationName: "방송통신대앞.이화장", externalStationId: "01877", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: true),
        MainBusStation(internalStationId: 01220,stationName: "혜화역.마로니에공원", externalStationId: "01220", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01592,stationName: "혜화역1번출구", externalStationId: "01592", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01226,stationName: "혜화동로터리", externalStationId: "01226", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01697,stationName: "성대입구", externalStationId: "01697", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01697,stationName: "성균관대 정문", externalStationId: "01697", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01616,stationName: "600주년 기념관", externalStationId: "01616", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01617,stationName: "성균관대운동장", externalStationId: "01617", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01618,stationName: "학생회관", externalStationId: "01618", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 01722,stationName: "성균관대학교", externalStationId: "01722", eta: "3개전", isFirstStation: false, isLastStation: true, isRotationStation: false)
    ]
    
    @Published var HSSCstations: [MainBusStation] = [
        MainBusStation(internalStationId: 90001,stationName: "농구장", externalStationId: "Basketball Court (Shuttle Bus Stop)", isFirstStation: true, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90002,stationName: "학생회관", externalStationId: "Student Center", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90003,stationName: "정문", externalStationId: "main Gate of SKKU", eta: "2개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90004,stationName: "혜화초등학교", externalStationId: "01532", eta: "도착 혹은 출발", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90005,stationName: "혜화우체국", externalStationId: "01543", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90006,stationName: "혜화역4번출구", externalStationId: "01876", eta: "도착 혹은 출발", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90007,stationName: "혜화역.서울대병원입구", externalStationId: "01221", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90008,stationName: "방송통신대앞.이화장", externalStationId: "01877", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: true),
        MainBusStation(internalStationId: 90009,stationName: "혜화역.마로니에공원", externalStationId: "01220", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90010,stationName: "혜화역1번출구", externalStationId: "01592", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90011,stationName: "혜화동로터리", externalStationId: "01226", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90012,stationName: "성대입구", externalStationId: "01697", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90013,stationName: "성균관대 정문", externalStationId: "01697", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90014,stationName: "600주년 기념관", externalStationId: "01616", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90015,stationName: "성균관대운동장", externalStationId: "01617", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90016,stationName: "학생회관", externalStationId: "01618", eta: "3개전", isFirstStation: false, isLastStation: false, isRotationStation: false),
        MainBusStation(internalStationId: 90017,stationName: "성균관대학교", externalStationId: "01722", eta: "3개전", isFirstStation: false, isLastStation: true, isRotationStation: false)
    ]
    
    func refreshBusStations() {
        print("Jonro07 Bus data fetch done")
    }
}
