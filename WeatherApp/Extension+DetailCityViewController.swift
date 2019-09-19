//
//  Extension+DetailCityViewController.swift
//  WeatherApp
//
//  Created by Артем on 15/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

extension DetailCityViewController {
    
    func configureCurrentUI() {
        
        tableViewForecast.isHidden = true
        stackviewCurrent.isHidden = false
        
        nameLabel.text = currentWeather.name
        nowTempLabel.text = currentWeather.weather![0].description
        tempLabel.text = (currentWeather.main?.temp!.description)! + " ℃"
        
        let icon = currentWeather.weather![0].icon
        
        let url: URL = URL(string: "http://openweathermap.org/img/wn/" + "\(icon!)" + "@2x.png")!
        
        if let imageData = try? Data(contentsOf: url) {
            let image = UIImage(data: imageData)
            iconImage.image = image
        }
        
        pressureLabel.text = "Pressure: " + (currentWeather.main?.pressure!.description)! + " mm"
        windLabel.text = "Wind " + (currentWeather.wind?.speed!.description)! + " m/c"
        humidityLabel.text = "Humidity: " + (currentWeather.main?.humidity!.description)! + " %"
        
    }
    
    func configureForecastUI(cell: UITableViewCell, with result: ForecastWeatherCity.List) {
        
        cell.textLabel?.text = result.dt_txt
        cell.detailTextLabel?.text = (result.main?.temp!.description)! + " ℃"
        
        let icon = result.weather![0].icon
        
        let url: URL = URL(string: "http://openweathermap.org/img/wn/" + "\(icon!)" + "@2x.png")!
        
        if let imageData = try? Data(contentsOf: url) {
            let image = UIImage(data: imageData)
            cell.imageView!.image = image
        }
    }
}
