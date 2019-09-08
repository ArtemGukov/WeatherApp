//
//  Data.swift
//  WeatherApp
//
//  Created by Артем on 05/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import Foundation

struct City: Codable {
    
    let location: Location
    let current: Current
}

struct Location: Codable {
    let lat: Double
    let lon: Double
    let name: String
    let region: String
    let country: String
    let tz_id: String
    let localtime_epoch: Int
    let localtime: String
}

struct Current: Codable {
    let last_updated: String?
    let last_updated_epoch: Int?
    let temp_c: Double?
    let temp_f: Double?
    let feelslike_c: Double
    let feelslike_f: Double
    
    let condition: Condition
    
    let wind_mph: Double
    let wind_kph: Double
    let wind_degree: Int
    let wind_dir: String
    let pressure_mb: Double
    let pressure_in: Double
    let precip_mm: Double
    let precip_in: Double
    let humidity: Int
    let cloud: Int
    let is_day: Int
    let uv: Double
    let gust_mph: Double
    let gust_kph: Double
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}
