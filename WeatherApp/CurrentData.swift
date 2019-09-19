//
//  CurrentData.swift
//  WeatherApp
//
//  Created by Артем on 10/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import Foundation

struct CurrentWeatherCity: Codable {
    
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let id: Int?
    let name: String?
    let cod: Int?
}

struct Coord: Codable {
    let lon: Double?
    let lat: Double?
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Codable {
    let temp: Double?
    let pressure: Double?
    let humidity: Int?
    let temp_min: Double?
    let temp_max: Double?
    let sea_level: Double?
    let grnd_level: Double?
    let temp_kf: Double?
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
}

struct Clouds: Codable {
    let all: Int?
}

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}

struct CurrentWeatherCities: Codable {
    let cities: [CurrentWeatherCity]
}
