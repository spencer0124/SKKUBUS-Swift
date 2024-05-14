//
//  HTTPClient.swift
//  skkumap
//
//  Created by 조승용 on 2024/01/03.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class HTTPClient {
    func getJongro07station(completion: @escaping (Result<[Jongro07BusStationInfo], NetworkError>) -> Void) {
        guard let url = URL.forJongroBusByNumber(07) else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let jongro07BusStationInfos = try? JSONDecoder().decode([Jongro07BusStationInfo].self, from: data) else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(jongro07BusStationInfos))
        }.resume()
    }
}
