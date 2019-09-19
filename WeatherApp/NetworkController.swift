//
//  NetworkController.swift
//  WeatherApp
//
//  Created by Артем on 13/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

var url = Url()

class NetworkControllerCurrent {

    static let shared = NetworkControllerCurrent()

    func fetchCityData(searchTerm: String, completion: @escaping (CurrentWeatherCity?) -> Void) {
    
        guard let urlCity = URL(string: url.base + url.current + searchTerm + url.appKey) else {
            
            return }
        
        URLSession.shared.dataTask(with: urlCity) { (data, _, _)  in
            
            if let data = data, let jsonData = try? JSONDecoder().decode(CurrentWeatherCity.self, from: data) {

                completion(jsonData)
            
            } else {
                completion(nil)
            }
        }.resume()
    }
}

class NetworkControllerForecast {
    
    static let shared = NetworkControllerForecast()
    
    func fetchCityData(searchTerm: String, completion: @escaping (ForecastWeatherCity?) -> Void) {
        
        guard let urlCity = URL(string: url.base + url.forecast5 + searchTerm + url.appKey) else {
            
            print("Wrong URL")
            return }
        
        URLSession.shared.dataTask(with: urlCity) { (data, _, _)  in
            
            if let data = data, let jsonData = try? JSONDecoder().decode(ForecastWeatherCity.self, from: data) {
                
                completion(jsonData)

            } else {
                
                completion(nil)
                
            }
            
        }.resume()
    }
}
