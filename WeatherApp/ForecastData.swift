//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Артем on 10/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import Foundation

struct ForecastWeatherCity: Codable {
    let code: Int?
    let message: Double?
    let city: City?
    let cnt: Int?
    let list: [List]?
    
    struct City: Codable {
        let id: Int?
        let name: String?
        let coord: Coord?
        let country: String?
        let timezone: Int?
    }

    struct List: Codable {
        let dt: Int?
        let main: Main?
        let weather: [Weather]?
        let clouds: Clouds?
        let wind: Wind?
        let dt_txt: String?
    }
}

struct ForecastWeatherCities: Codable {
    let cities: [ForecastWeatherCity]
}

