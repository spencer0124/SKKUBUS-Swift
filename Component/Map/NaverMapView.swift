//
//  NaverMapView.swift
//  skkumap
//
//  Created by 조승용 on 2024/05/17.
//

import SwiftUI
import NMapsMap
import CoreLocation

struct NaverMap: UIViewRepresentable {
   
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
           
        }
    
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView = context.coordinator.getNaverMapView()
        return mapView
    }
    
    
}

final class Coordinator: NSObject, ObservableObject, NMFMapViewCameraDelegate, NMFMapViewTouchDelegate, CLLocationManagerDelegate {
    static let shared = Coordinator()
    
    let view = NMFNaverMapView(frame: .zero)
    
    @Published var coord: (Double, Double) = (0.0, 0.0)
    @Published var userLocation: (Double, Double) = (0.0, 0.0)
    
    var locationManager: CLLocationManager?
    
    override init() {
        super.init()
            
        let initlat = 37.587241
        let initlng = 126.992858
        
        let defaultCameraPosition = NMFCameraPosition(NMGLatLng(lat: initlat, lng: initlng), zoom: 15.8, tilt: 50, heading: 330)
        
        view.mapView.moveCamera(NMFCameraUpdate(position: defaultCameraPosition))
        view.mapView.positionMode = .direction
        view.mapView.isNightModeEnabled = false
        
        view.mapView.minZoomLevel = 10 // 최소 줌 레벨
        view.mapView.maxZoomLevel = 17 // 최대 줌 레벨
        
        view.showLocationButton = false
        view.showZoomControls = false // 줌 확대, 축소 버튼 활성화
        view.showCompass = false
        view.showScaleBar = false
        
        view.mapView.addCameraDelegate(delegate: self)
        view.mapView.touchDelegate = self
        
        addMarkersToMap()
        addPathOverlays(to: view.mapView)
    }
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager!.delegate = self
            self.locationManager!.requestWhenInUseAuthorization() // Request authorization
        } else {
            print("Location services are off.")
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Location access is restricted or denied.")
        case .authorizedAlways, .authorizedWhenInUse:
//            updateLocation(locationManager.location)
            print("ready to go")
        @unknown default:
            break
        }
    }
    
//    func updateLocation(_ location: CLLocation?) {
//        guard let location = location else { return }
//        coord = (location.coordinate.latitude, location.coordinate.longitude)
//        userLocation = (location.coordinate.latitude, location.coordinate.longitude)
//        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
//        cameraUpdate.animation = .easeIn
//        view.mapView.moveCamera(cameraUpdate)
//        updateLocationOverlay(location)
//    }
//    
//    func updateLocationOverlay(_ location: CLLocation) {
//        let locationOverlay = view.mapView.locationOverlay
//        locationOverlay.location = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
//        locationOverlay.hidden = false
//        locationOverlay.icon = NMFOverlayImage(name: "location_overlay_icon")
//        locationOverlay.iconWidth = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
//        locationOverlay.iconHeight = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
//        locationOverlay.anchor = CGPoint(x: 0.5, y: 1)
//    }
    
    func getNaverMapView() -> NMFNaverMapView {
        return view
    }
    
    // Add campus markers
    func addMarkersToMap() {
        campusMarkers.forEach { markerData in
            let marker = NMFMarker(position: NMGLatLng(lat: markerData.position.0, lng: markerData.position.1))
            marker.iconImage = NMFOverlayImage(name: "line_blank")
            marker.width = 25
            marker.height = 25
            
            marker.captionText = markerData.idNumber
            marker.captionAligns = [NMFAlignType.top]
            marker.captionOffset = -12
            marker.captionTextSize = 8
            marker.mapView = view.mapView
        }
    }
    
    // Add path overlays
    func addPathOverlays(to mapView: NMFMapView) {
        let routes = [jongro07Route, jongro02Route] // 경로 배열
        let colors = [UIColor.customDeepGreen1, UIColor.customDeepGreen1] // 각 경로에 적용할 색상 배열
        
        for (index, route) in routes.enumerated() {
            createAndAddPath(route: route, color: colors[index], to: mapView)
        }
    }

    private func createAndAddPath(route: [NMGLatLng], color: UIColor, to mapView: NMFMapView) {
        let pathOverlay = NMFPath()
        pathOverlay.path = NMGLineString(points: route)
        pathOverlay.width = 3
        pathOverlay.color = color
        pathOverlay.outlineWidth = 2.5
        pathOverlay.outlineColor = UIColor.white
        pathOverlay.mapView = mapView
    }
    
    
}

// MARK: - Campus Markers

struct CampusMarker {
    var idNumber: String
    var position: (Double, Double) // Latitude, Longitude
}

let campusMarkers: [CampusMarker] = [
    CampusMarker(idNumber: "1", position: (37.587361, 126.994479)),
    CampusMarker(idNumber: "2", position: (37.587441, 126.990506)),
    CampusMarker(idNumber: "4", position: (37.588636, 126.993209)),
    CampusMarker(idNumber: "7", position: (37.588353, 126.994262)),
    CampusMarker(idNumber: "8", position: (37.58752, 126.99322)),
    CampusMarker(idNumber: "9", position: (37.586819, 126.995246)),
    CampusMarker(idNumber: "31", position: (37.589184, 126.991539)),
    CampusMarker(idNumber: "32", position: (37.589053, 126.992435)),
    CampusMarker(idNumber: "33", position: (37.588572, 126.992666)),
    CampusMarker(idNumber: "61", position: (37.587882, 126.991079)),
    CampusMarker(idNumber: "62", position: (37.588160, 126.990868))
]

// MARK: - Routes

let jongro02Route: [NMGLatLng] = [
    NMGLatLng(lat: 37.589193, lng: 126.990043),
    NMGLatLng(lat: 37.589103, lng: 126.990247),
    NMGLatLng(lat: 37.589001, lng: 126.990462),
    NMGLatLng(lat: 37.588891, lng: 126.990622),
    NMGLatLng(lat: 37.588797, lng: 126.990687),
    NMGLatLng(lat: 37.588653, lng: 126.990612),
    NMGLatLng(lat: 37.588598, lng: 126.990435),
    NMGLatLng(lat: 37.588615, lng: 126.990268),
    NMGLatLng(lat: 37.588691, lng: 126.990172),
    NMGLatLng(lat: 37.588717, lng: 126.990059),
    NMGLatLng(lat: 37.588678, lng: 126.989952),
    NMGLatLng(lat: 37.588568, lng: 126.98992),
    NMGLatLng(lat: 37.588466, lng: 126.990011),
    NMGLatLng(lat: 37.588406, lng: 126.990048),
    NMGLatLng(lat: 37.588377, lng: 126.990199),
    NMGLatLng(lat: 37.588394, lng: 126.990204),
    NMGLatLng(lat: 37.588457, lng: 126.990107),
    NMGLatLng(lat: 37.588568, lng: 126.990016),
    NMGLatLng(lat: 37.588644, lng: 126.990048),
    NMGLatLng(lat: 37.588623, lng: 126.990161),
    NMGLatLng(lat: 37.588521, lng: 126.990344),
    NMGLatLng(lat: 37.588525, lng: 126.990467),
    NMGLatLng(lat: 37.58861, lng: 126.990655),
    NMGLatLng(lat: 37.588831, lng: 126.990762),
    NMGLatLng(lat: 37.588989, lng: 126.990633),
    NMGLatLng(lat: 37.589086, lng: 126.990445),
    NMGLatLng(lat: 37.58921, lng: 126.990209),
    NMGLatLng(lat: 37.589265, lng: 126.990065),
    NMGLatLng(lat: 37.589269, lng: 126.989984),
    NMGLatLng(lat: 37.589274, lng: 126.989969),
    NMGLatLng(lat: 37.589329, lng: 126.989862),
    NMGLatLng(lat: 37.589371, lng: 126.989685),
    NMGLatLng(lat: 37.589359, lng: 126.989417),
    NMGLatLng(lat: 37.589218, lng: 126.989148),
    NMGLatLng(lat: 37.589023, lng: 126.989063),
    NMGLatLng(lat: 37.588819, lng: 126.988939),
    NMGLatLng(lat: 37.588921, lng: 126.988676),
    NMGLatLng(lat: 37.588912, lng: 126.988306),
    NMGLatLng(lat: 37.588806, lng: 126.988038),
    NMGLatLng(lat: 37.588636, lng: 126.987791),
    NMGLatLng(lat: 37.588866, lng: 126.987582),
    NMGLatLng(lat: 37.588904, lng: 126.98726),
    NMGLatLng(lat: 37.58907, lng: 126.987201),
    NMGLatLng(lat: 37.589206, lng: 126.987062),
    NMGLatLng(lat: 37.589218, lng: 126.986622),
    NMGLatLng(lat: 37.589206, lng: 126.986332),
    NMGLatLng(lat: 37.589023, lng: 126.986096),
    NMGLatLng(lat: 37.588789, lng: 126.985935),
    NMGLatLng(lat: 37.588504, lng: 126.985753),
    NMGLatLng(lat: 37.588194, lng: 126.985629),
    NMGLatLng(lat: 37.587858, lng: 126.985613),
    NMGLatLng(lat: 37.587514, lng: 126.985651),
    NMGLatLng(lat: 37.587118, lng: 126.985495),
    NMGLatLng(lat: 37.586766, lng: 126.985302),
    NMGLatLng(lat: 37.586553, lng: 126.985222),
    NMGLatLng(lat: 37.58643, lng: 126.985249),
    NMGLatLng(lat: 37.586379, lng: 126.985302),
    NMGLatLng(lat: 37.586337, lng: 126.985269),
    NMGLatLng(lat: 37.586221, lng: 126.985533),
    NMGLatLng(lat: 37.586177, lng: 126.985559),
    NMGLatLng(lat: 37.586032, lng: 126.985521),
    NMGLatLng(lat: 37.585064, lng: 126.985058),
    NMGLatLng(lat: 37.584956, lng: 126.985036),
    NMGLatLng(lat: 37.584078, lng: 126.98501),
    NMGLatLng(lat: 37.583313, lng: 126.985),
    NMGLatLng(lat: 37.583313, lng: 126.985),
    NMGLatLng(lat: 37.581334, lng: 126.984976),
    NMGLatLng(lat: 37.579544, lng: 126.984921),
    NMGLatLng(lat: 37.579315, lng: 126.984935),
    NMGLatLng(lat: 37.579262, lng: 126.984938),
    NMGLatLng(lat: 37.579262, lng: 126.984938),
    NMGLatLng(lat: 37.579216, lng: 126.984959),
    NMGLatLng(lat: 37.577781, lng: 126.985608),
    NMGLatLng(lat: 37.576876, lng: 126.986094),
    NMGLatLng(lat: 37.576805, lng: 126.986132),
    NMGLatLng(lat: 37.576826, lng: 126.986105),
    NMGLatLng(lat: 37.576742, lng: 126.986121),
    NMGLatLng(lat: 37.576612, lng: 126.986145),
    NMGLatLng(lat: 37.575955, lng: 126.986381),
    NMGLatLng(lat: 37.575087, lng: 126.986698),
    NMGLatLng(lat: 37.575087, lng: 126.986698),
    NMGLatLng(lat: 37.574942, lng: 126.986751),
    NMGLatLng(lat: 37.574646, lng: 126.98691),
    NMGLatLng(lat: 37.574591, lng: 126.986939),
    NMGLatLng(lat: 37.574536, lng: 126.986969),
    NMGLatLng(lat: 37.574101, lng: 126.987203),
    NMGLatLng(lat: 37.573483, lng: 126.987565),
    NMGLatLng(lat: 37.573468, lng: 126.987573),
    NMGLatLng(lat: 37.573468, lng: 126.987573),
    NMGLatLng(lat: 37.573452, lng: 126.987581),
    NMGLatLng(lat: 37.57321, lng: 126.98769),
    NMGLatLng(lat: 37.57299, lng: 126.987728),
    NMGLatLng(lat: 37.572808, lng: 126.987721),
    NMGLatLng(lat: 37.572594, lng: 126.98767),
    NMGLatLng(lat: 37.572583, lng: 126.987667),
    NMGLatLng(lat: 37.572583, lng: 126.987667),
    NMGLatLng(lat: 37.572499, lng: 126.98766),
    NMGLatLng(lat: 37.571154, lng: 126.987535),
    NMGLatLng(lat: 37.571079, lng: 126.987528),
    NMGLatLng(lat: 37.571079, lng: 126.987528),
    NMGLatLng(lat: 37.571066, lng: 126.98753),
    NMGLatLng(lat: 37.570255, lng: 126.987593),
    NMGLatLng(lat: 37.570149, lng: 126.987602),
    NMGLatLng(lat: 37.570254, lng: 126.987682),
    NMGLatLng(lat: 37.570255, lng: 126.987593),
    NMGLatLng(lat: 37.570261, lng: 126.986934),
    NMGLatLng(lat: 37.570273, lng: 126.98576),
    NMGLatLng(lat: 37.570273, lng: 126.98576),
    NMGLatLng(lat: 37.570285, lng: 126.984453),
    NMGLatLng(lat: 37.570291, lng: 126.983693),
    NMGLatLng(lat: 37.570291, lng: 126.983693),
    NMGLatLng(lat: 37.570355, lng: 126.98345),
    NMGLatLng(lat: 37.570413, lng: 126.983325),
    NMGLatLng(lat: 37.570546, lng: 126.983175),
    NMGLatLng(lat: 37.57072, lng: 126.983076),
    NMGLatLng(lat: 37.57072, lng: 126.983076),
    NMGLatLng(lat: 37.570736, lng: 126.983077),
    NMGLatLng(lat: 37.570763, lng: 126.98308),
    NMGLatLng(lat: 37.571987, lng: 126.983089),
    NMGLatLng(lat: 37.572006, lng: 126.983089),
    NMGLatLng(lat: 37.572006, lng: 126.983089),
    NMGLatLng(lat: 37.572024, lng: 126.983088),
    NMGLatLng(lat: 37.575083, lng: 126.982924),
    NMGLatLng(lat: 37.575129, lng: 126.982946),
    NMGLatLng(lat: 37.575129, lng: 126.982946),
    NMGLatLng(lat: 37.575392, lng: 126.98307),
    NMGLatLng(lat: 37.575444, lng: 126.983094),
    NMGLatLng(lat: 37.575469, lng: 126.983106),
    NMGLatLng(lat: 37.575497, lng: 126.983119),
    NMGLatLng(lat: 37.575423, lng: 126.983019),
    NMGLatLng(lat: 37.575425, lng: 126.983024),
    NMGLatLng(lat: 37.575431, lng: 126.983046),
    NMGLatLng(lat: 37.575444, lng: 126.983094),
    NMGLatLng(lat: 37.575454, lng: 126.983129),
    NMGLatLng(lat: 37.575471, lng: 126.983192),
    NMGLatLng(lat: 37.575792, lng: 126.984021),
    NMGLatLng(lat: 37.575939, lng: 126.984347),
    NMGLatLng(lat: 37.576742, lng: 126.986121),
    NMGLatLng(lat: 37.576783, lng: 126.986211),
    NMGLatLng(lat: 37.576848, lng: 126.986238),
    NMGLatLng(lat: 37.576928, lng: 126.986194),
    NMGLatLng(lat: 37.577815, lng: 126.985713),
    NMGLatLng(lat: 37.579198, lng: 126.985085),
    NMGLatLng(lat: 37.579261, lng: 126.985056),
    NMGLatLng(lat: 37.579261, lng: 126.985056),
    NMGLatLng(lat: 37.5793, lng: 126.985053),
    NMGLatLng(lat: 37.579546, lng: 126.985034),
    NMGLatLng(lat: 37.581333, lng: 126.985089),
    NMGLatLng(lat: 37.583266, lng: 126.985113),
    NMGLatLng(lat: 37.583311, lng: 126.985113),
    NMGLatLng(lat: 37.583311, lng: 126.985113),
    NMGLatLng(lat: 37.58335, lng: 126.985114),
    NMGLatLng(lat: 37.584077, lng: 126.985123),
    NMGLatLng(lat: 37.584947, lng: 126.985149),
    NMGLatLng(lat: 37.585041, lng: 126.985168),
    NMGLatLng(lat: 37.586007, lng: 126.985631),
    NMGLatLng(lat: 37.586189, lng: 126.985677),
    NMGLatLng(lat: 37.586286, lng: 126.985619),
    NMGLatLng(lat: 37.586387, lng: 126.985376),
    NMGLatLng(lat: 37.586411, lng: 126.985319),
    NMGLatLng(lat: 37.586362, lng: 126.98534),
    NMGLatLng(lat: 37.586371, lng: 126.985517),
    NMGLatLng(lat: 37.586541, lng: 126.985705),
    NMGLatLng(lat: 37.586902, lng: 126.985935),
    NMGLatLng(lat: 37.587208, lng: 126.986139),
    NMGLatLng(lat: 37.587604, lng: 126.986268),
    NMGLatLng(lat: 37.588075, lng: 126.986322),
    NMGLatLng(lat: 37.588318, lng: 126.986472),
    NMGLatLng(lat: 37.588709, lng: 126.986606),
    NMGLatLng(lat: 37.588488, lng: 126.986933),
    NMGLatLng(lat: 37.588428, lng: 126.987325),
    NMGLatLng(lat: 37.588194, lng: 126.987657),
    NMGLatLng(lat: 37.588139, lng: 126.987883),
    NMGLatLng(lat: 37.588279, lng: 126.988183),
    NMGLatLng(lat: 37.588488, lng: 126.988441),
    NMGLatLng(lat: 37.58836, lng: 126.988907),
    NMGLatLng(lat: 37.588382, lng: 126.989202),
    NMGLatLng(lat: 37.588598, lng: 126.989535),
    NMGLatLng(lat: 37.588768, lng: 126.989583),
    NMGLatLng(lat: 37.588977, lng: 126.989546),
    NMGLatLng(lat: 37.589032, lng: 126.989771),
    NMGLatLng(lat: 37.589108, lng: 126.989964),
    NMGLatLng(lat: 37.589249, lng: 126.989986),
    NMGLatLng(lat: 37.589193, lng: 126.990043),
    NMGLatLng(lat: 37.589103, lng: 126.990247),
    NMGLatLng(lat: 37.589001, lng: 126.990462),
    NMGLatLng(lat: 37.588891, lng: 126.990622),
    NMGLatLng(lat: 37.588797, lng: 126.990687),
    NMGLatLng(lat: 37.588653, lng: 126.990612),
    NMGLatLng(lat: 37.588598, lng: 126.990435),
    NMGLatLng(lat: 37.588615, lng: 126.990268),
    NMGLatLng(lat: 37.588691, lng: 126.990172),
    NMGLatLng(lat: 37.588717, lng: 126.990059),
    NMGLatLng(lat: 37.588678, lng: 126.989952),
    NMGLatLng(lat: 37.588568, lng: 126.98992),
    NMGLatLng(lat: 37.588466, lng: 126.990011),
    NMGLatLng(lat: 37.588406, lng: 126.990048),
    NMGLatLng(lat: 37.588377, lng: 126.990199),

    
]


let jongro07Route: [NMGLatLng] = [
    NMGLatLng(lat: 37.583014, lng: 126.998763),
    NMGLatLng(lat: 37.583063, lng: 126.998714),
    NMGLatLng(lat: 37.584114, lng: 126.997674),
    NMGLatLng(lat: 37.584619, lng: 126.99734),
    NMGLatLng(lat: 37.584843, lng: 126.997208),
    NMGLatLng(lat: 37.584957, lng: 126.997181),
    NMGLatLng(lat: 37.585721, lng: 126.996898),
    NMGLatLng(lat: 37.585776, lng: 126.996877),
    NMGLatLng(lat: 37.585833, lng: 126.996864),
    NMGLatLng(lat: 37.586395, lng: 126.996728),
    NMGLatLng(lat: 37.586435, lng: 126.996716),
    NMGLatLng(lat: 37.586493, lng: 126.996698),
    NMGLatLng(lat: 37.586551, lng: 126.996681),
    NMGLatLng(lat: 37.586634, lng: 126.996656),
    NMGLatLng(lat: 37.587223, lng: 126.996526),
    NMGLatLng(lat: 37.587343, lng: 126.996542),
    NMGLatLng(lat: 37.587775, lng: 126.996701),
    NMGLatLng(lat: 37.587775, lng: 126.996701),
    NMGLatLng(lat: 37.588845, lng: 126.997093),
    NMGLatLng(lat: 37.588896, lng: 126.997112),
    NMGLatLng(lat: 37.588957, lng: 126.997147),
    NMGLatLng(lat: 37.589161, lng: 126.997263),
    NMGLatLng(lat: 37.589248, lng: 126.997353),
    NMGLatLng(lat: 37.589277, lng: 126.997405),
    NMGLatLng(lat: 37.589277, lng: 126.997405),
    NMGLatLng(lat: 37.589392, lng: 126.99761),
    NMGLatLng(lat: 37.589579, lng: 126.998124),
    NMGLatLng(lat: 37.589701, lng: 126.998253),
    NMGLatLng(lat: 37.589744, lng: 126.998299),
    NMGLatLng(lat: 37.589787, lng: 126.998345),
    NMGLatLng(lat: 37.589932, lng: 126.998498),
    NMGLatLng(lat: 37.589934, lng: 126.998597),
    NMGLatLng(lat: 37.589837, lng: 126.998847),
    NMGLatLng(lat: 37.589799, lng: 126.999058),
    NMGLatLng(lat: 37.589786, lng: 126.999126),
    NMGLatLng(lat: 37.589776, lng: 126.999183),
    NMGLatLng(lat: 37.589807, lng: 126.99912),
    NMGLatLng(lat: 37.589786, lng: 126.999126),
    NMGLatLng(lat: 37.589715, lng: 126.999146),
    NMGLatLng(lat: 37.589314, lng: 126.99926),
    NMGLatLng(lat: 37.588208, lng: 126.999613),
    NMGLatLng(lat: 37.587883, lng: 126.999705),
    NMGLatLng(lat: 37.587824, lng: 126.999722),
    NMGLatLng(lat: 37.587765, lng: 126.999738),
    NMGLatLng(lat: 37.587542, lng: 126.999801),
    NMGLatLng(lat: 37.587484, lng: 126.999818),
    NMGLatLng(lat: 37.587426, lng: 126.999834),
    NMGLatLng(lat: 37.587191, lng: 126.999901),
    NMGLatLng(lat: 37.587096, lng: 126.999928),
    NMGLatLng(lat: 37.587047, lng: 126.999941),
    NMGLatLng(lat: 37.586984, lng: 126.999971),
    NMGLatLng(lat: 37.586799, lng: 127.000059),
    NMGLatLng(lat: 37.58645, lng: 127.000289),
    NMGLatLng(lat: 37.585784, lng: 127.000909),
    NMGLatLng(lat: 37.585777, lng: 127.000915),
    NMGLatLng(lat: 37.585804, lng: 127.000944),
    NMGLatLng(lat: 37.585784, lng: 127.000909),
    NMGLatLng(lat: 37.585741, lng: 127.000837),
    NMGLatLng(lat: 37.585658, lng: 127.000787),
    NMGLatLng(lat: 37.585533, lng: 127.00075),
    NMGLatLng(lat: 37.585408, lng: 127.000775),
    NMGLatLng(lat: 37.585314, lng: 127.000856),
    NMGLatLng(lat: 37.585286, lng: 127.000884),
    NMGLatLng(lat: 37.585208, lng: 127.001009),
    NMGLatLng(lat: 37.585193, lng: 127.001071),
    NMGLatLng(lat: 37.585191, lng: 127.001175),
    NMGLatLng(lat: 37.5852, lng: 127.001274),
    NMGLatLng(lat: 37.585178, lng: 127.001178),
    NMGLatLng(lat: 37.583848, lng: 127.001476),
    NMGLatLng(lat: 37.583813, lng: 127.001484),
    NMGLatLng(lat: 37.583728, lng: 127.001498),
    NMGLatLng(lat: 37.583173, lng: 127.001592),
    NMGLatLng(lat: 37.582421, lng: 127.001719),
    NMGLatLng(lat: 37.582369, lng: 127.001727),
    NMGLatLng(lat: 37.582369, lng: 127.001727),
    NMGLatLng(lat: 37.582331, lng: 127.001734),
    NMGLatLng(lat: 37.581732, lng: 127.001833),
    NMGLatLng(lat: 37.580924, lng: 127.001939),
    NMGLatLng(lat: 37.58004, lng: 127.00201),
    NMGLatLng(lat: 37.579991, lng: 127.002014),
    NMGLatLng(lat: 37.579991, lng: 127.002014),
    NMGLatLng(lat: 37.579956, lng: 127.002017),
    NMGLatLng(lat: 37.579558, lng: 127.002049),
    NMGLatLng(lat: 37.57678, lng: 127.002108),
    NMGLatLng(lat: 37.576363, lng: 127.002117),
    NMGLatLng(lat: 37.576216, lng: 127.002073),
    NMGLatLng(lat: 37.576162, lng: 127.002057),
    NMGLatLng(lat: 37.576167, lng: 127.002277),
    NMGLatLng(lat: 37.576233, lng: 127.002298),
    NMGLatLng(lat: 37.576353, lng: 127.002335),
    NMGLatLng(lat: 37.576724, lng: 127.002327),
    NMGLatLng(lat: 37.576784, lng: 127.002326),
    NMGLatLng(lat: 37.576844, lng: 127.002325),
    NMGLatLng(lat: 37.579515, lng: 127.002268),
    NMGLatLng(lat: 37.579562, lng: 127.002267),
    NMGLatLng(lat: 37.579636, lng: 127.002261),
    NMGLatLng(lat: 37.580009, lng: 127.002231),
    NMGLatLng(lat: 37.579998, lng: 127.002181),
    NMGLatLng(lat: 37.580015, lng: 127.002187),
    NMGLatLng(lat: 37.580036, lng: 127.002192),
    NMGLatLng(lat: 37.580585, lng: 127.00216),
    NMGLatLng(lat: 37.581154, lng: 127.002122),
    NMGLatLng(lat: 37.581873, lng: 127.002047),
    NMGLatLng(lat: 37.582362, lng: 127.001988),
    NMGLatLng(lat: 37.582383, lng: 127.001983),
    NMGLatLng(lat: 37.582404, lng: 127.001977),
    NMGLatLng(lat: 37.582418, lng: 127.00193),
    NMGLatLng(lat: 37.582489, lng: 127.001922),
    NMGLatLng(lat: 37.582935, lng: 127.001842),
    NMGLatLng(lat: 37.583301, lng: 127.001751),
    NMGLatLng(lat: 37.583726, lng: 127.00166),
    NMGLatLng(lat: 37.583964, lng: 127.001595),
    NMGLatLng(lat: 37.585142, lng: 127.001386),
    NMGLatLng(lat: 37.585222, lng: 127.001367),
    NMGLatLng(lat: 37.585211, lng: 127.001318),
    NMGLatLng(lat: 37.585228, lng: 127.001361),
    NMGLatLng(lat: 37.585275, lng: 127.001447),
    NMGLatLng(lat: 37.585316, lng: 127.001512),
    NMGLatLng(lat: 37.585408, lng: 127.001562),
    NMGLatLng(lat: 37.585533, lng: 127.001587),
    NMGLatLng(lat: 37.585625, lng: 127.001575),
    NMGLatLng(lat: 37.585678, lng: 127.001559),
    NMGLatLng(lat: 37.585712, lng: 127.001527),
    NMGLatLng(lat: 37.585738, lng: 127.001485),
    NMGLatLng(lat: 37.585741, lng: 127.001488),
    NMGLatLng(lat: 37.585777, lng: 127.001469),
    NMGLatLng(lat: 37.585803, lng: 127.001435),
    NMGLatLng(lat: 37.585835, lng: 127.001354),
    NMGLatLng(lat: 37.585837, lng: 127.001356),
    NMGLatLng(lat: 37.58585, lng: 127.001298),
    NMGLatLng(lat: 37.585851, lng: 127.001297),
    NMGLatLng(lat: 37.585859, lng: 127.00124),
    NMGLatLng(lat: 37.585859, lng: 127.00124),
    NMGLatLng(lat: 37.585865, lng: 127.001179),
    NMGLatLng(lat: 37.585841, lng: 127.001025),
    NMGLatLng(lat: 37.585804, lng: 127.000944),
    NMGLatLng(lat: 37.585804, lng: 127.000944),
    NMGLatLng(lat: 37.585784, lng: 127.000909),
    NMGLatLng(lat: 37.585741, lng: 127.000837),
    NMGLatLng(lat: 37.585658, lng: 127.000787),
    NMGLatLng(lat: 37.585533, lng: 127.00075),
    NMGLatLng(lat: 37.585408, lng: 127.000775),
    NMGLatLng(lat: 37.585314, lng: 127.000856),
    NMGLatLng(lat: 37.585286, lng: 127.000884),
    NMGLatLng(lat: 37.585286, lng: 127.000884),
    NMGLatLng(lat: 37.585164, lng: 127.00078),
    NMGLatLng(lat: 37.58501, lng: 127.000647),
    NMGLatLng(lat: 37.584867, lng: 127.000527),
    NMGLatLng(lat: 37.584856, lng: 127.000517),
    NMGLatLng(lat: 37.584748, lng: 127.000424),
    NMGLatLng(lat: 37.584329, lng: 127.000068),
    NMGLatLng(lat: 37.584197, lng: 126.99994),
    NMGLatLng(lat: 37.583708, lng: 126.999429),
    NMGLatLng(lat: 37.583063, lng: 126.998714),
    NMGLatLng(lat: 37.583046, lng: 126.998696),
    NMGLatLng(lat: 37.58303, lng: 126.9988),
    NMGLatLng(lat: 37.583043, lng: 126.998779),
    NMGLatLng(lat: 37.583055, lng: 126.998757),
    NMGLatLng(lat: 37.5834, lng: 126.998462),
    NMGLatLng(lat: 37.583825, lng: 126.998071),
    NMGLatLng(lat: 37.583948, lng: 126.997947),
    NMGLatLng(lat: 37.584016, lng: 126.997845),
    NMGLatLng(lat: 37.584118, lng: 126.997738),
    NMGLatLng(lat: 37.58442, lng: 126.997534),
    NMGLatLng(lat: 37.584556, lng: 126.997454),
    NMGLatLng(lat: 37.584913, lng: 126.997293),
    NMGLatLng(lat: 37.584943, lng: 126.997266),
    NMGLatLng(lat: 37.584964, lng: 126.997255),
    NMGLatLng(lat: 37.584981, lng: 126.99721),
    NMGLatLng(lat: 37.584977, lng: 126.997173),
    NMGLatLng(lat: 37.584973, lng: 126.99713),
    NMGLatLng(lat: 37.584824, lng: 126.995939),
    NMGLatLng(lat: 37.58482, lng: 126.995788),
    NMGLatLng(lat: 37.584883, lng: 126.995681),
    NMGLatLng(lat: 37.584956, lng: 126.995585),
    NMGLatLng(lat: 37.585041, lng: 126.995488),
    NMGLatLng(lat: 37.58513, lng: 126.995408),
    NMGLatLng(lat: 37.585296, lng: 126.99529),
    NMGLatLng(lat: 37.585598, lng: 126.995107),
    NMGLatLng(lat: 37.585972, lng: 126.994834),
    NMGLatLng(lat: 37.586546, lng: 126.994415),
    NMGLatLng(lat: 37.587081, lng: 126.994056),
    NMGLatLng(lat: 37.587387, lng: 126.993825),
    NMGLatLng(lat: 37.58774, lng: 126.993616),
    NMGLatLng(lat: 37.587761, lng: 126.993605),
    NMGLatLng(lat: 37.587783, lng: 126.993594),
    NMGLatLng(lat: 37.587779, lng: 126.993587),
    NMGLatLng(lat: 37.587804, lng: 126.993587),
    NMGLatLng(lat: 37.587838, lng: 126.993571),
    NMGLatLng(lat: 37.588068, lng: 126.993453),
    NMGLatLng(lat: 37.588217, lng: 126.993345),
    NMGLatLng(lat: 37.588518, lng: 126.99312),
    NMGLatLng(lat: 37.588544, lng: 126.993088),
    NMGLatLng(lat: 37.588565, lng: 126.993061),
    NMGLatLng(lat: 37.588582, lng: 126.993007),
    NMGLatLng(lat: 37.588574, lng: 126.992975),
    NMGLatLng(lat: 37.588561, lng: 126.992943),
    NMGLatLng(lat: 37.588374, lng: 126.992551),
    NMGLatLng(lat: 37.588238, lng: 126.99224),
    NMGLatLng(lat: 37.588221, lng: 126.992208),
    NMGLatLng(lat: 37.588208, lng: 126.992181),
    NMGLatLng(lat: 37.588157, lng: 126.992154),
    NMGLatLng(lat: 37.588136, lng: 126.992165),
    NMGLatLng(lat: 37.58811, lng: 126.992187),
    NMGLatLng(lat: 37.588025, lng: 126.992321),
    NMGLatLng(lat: 37.587974, lng: 126.992406),
    NMGLatLng(lat: 37.587898, lng: 126.992471),
    NMGLatLng(lat: 37.587804, lng: 126.992514),
    NMGLatLng(lat: 37.587605, lng: 126.992562),
    NMGLatLng(lat: 37.587502, lng: 126.992583),
    NMGLatLng(lat: 37.587417, lng: 126.992632),
    NMGLatLng(lat: 37.587375, lng: 126.992702),
    NMGLatLng(lat: 37.587366, lng: 126.992782),
    NMGLatLng(lat: 37.587405, lng: 126.992857),
    NMGLatLng(lat: 37.587443, lng: 126.992895),
    NMGLatLng(lat: 37.587511, lng: 126.992964),
    NMGLatLng(lat: 37.587575, lng: 126.993131),
    NMGLatLng(lat: 37.587707, lng: 126.993495),
    NMGLatLng(lat: 37.587728, lng: 126.993533),
    NMGLatLng(lat: 37.587745, lng: 126.993571),
    NMGLatLng(lat: 37.587753, lng: 126.993506),
    NMGLatLng(lat: 37.587732, lng: 126.993522),
    NMGLatLng(lat: 37.587702, lng: 126.993538),
    NMGLatLng(lat: 37.587545, lng: 126.993624),
    NMGLatLng(lat: 37.587265, lng: 126.993801),
    NMGLatLng(lat: 37.587129, lng: 126.993903),
    NMGLatLng(lat: 37.585968, lng: 126.994708),
    NMGLatLng(lat: 37.585258, lng: 126.995201),
    NMGLatLng(lat: 37.585092, lng: 126.995309),
    NMGLatLng(lat: 37.584986, lng: 126.995394),
    NMGLatLng(lat: 37.584897, lng: 126.995491),
    NMGLatLng(lat: 37.58482, lng: 126.995604),
    NMGLatLng(lat: 37.584756, lng: 126.995743),
    NMGLatLng(lat: 37.584718, lng: 126.995883),
    NMGLatLng(lat: 37.584744, lng: 126.996145),
    NMGLatLng(lat: 37.584803, lng: 126.996698),
    NMGLatLng(lat: 37.584863, lng: 126.997192),
    NMGLatLng(lat: 37.584867, lng: 126.997229),
    NMGLatLng(lat: 37.584871, lng: 126.997251),
    NMGLatLng(lat: 37.584963, lng: 126.997249),
    NMGLatLng(lat: 37.584993, lng: 126.997233),
    NMGLatLng(lat: 37.585027, lng: 126.997222),
    NMGLatLng(lat: 37.585324, lng: 126.997104),
    NMGLatLng(lat: 37.585562, lng: 126.997002),
    NMGLatLng(lat: 37.586034, lng: 126.996863),
    NMGLatLng(lat: 37.58654, lng: 126.996734),
    NMGLatLng(lat: 37.587203, lng: 126.996573),
    NMGLatLng(lat: 37.587297, lng: 126.996573),
    NMGLatLng(lat: 37.587369, lng: 126.996594),
    NMGLatLng(lat: 37.587705, lng: 126.99668),
    NMGLatLng(lat: 37.587739, lng: 126.996696),
    NMGLatLng(lat: 37.587769, lng: 126.996712),
    NMGLatLng(lat: 37.587775, lng: 126.996701),
    NMGLatLng(lat: 37.588845, lng: 126.997093),
    NMGLatLng(lat: 37.588896, lng: 126.997112),
    NMGLatLng(lat: 37.588957, lng: 126.997147),
    NMGLatLng(lat: 37.589161, lng: 126.997263),
    NMGLatLng(lat: 37.589248, lng: 126.997353),
    NMGLatLng(lat: 37.589277, lng: 126.997405),
    // 종로 07 끝
    
    
    

   ]
