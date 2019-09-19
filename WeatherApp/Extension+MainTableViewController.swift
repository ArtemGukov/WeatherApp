//
//  Extension+MainTableViewController.swift
//  WeatherApp
//
//  Created by Артем on 14/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

extension MainTableViewController {
    func configure(cell: CityMainTableViewCell, with current: CurrentWeatherCity) {
        
        cell.nameLabel.text = current.name
        cell.tempLabel.text = (current.main?.temp!.description)! + " ℃"
        
        let icon = current.weather![0].icon
        
        let url: URL = URL(string: "http://openweathermap.org/img/wn/" + "\(icon!)" + "@2x.png")!
        
        if let imageData = try? Data(contentsOf: url) {
            let image = UIImage(data: imageData)
            cell.iconImage.image = image
        }
    }
}
