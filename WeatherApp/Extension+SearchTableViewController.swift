//
//  Extension+SearchTableViewController.swift
//  WeatherApp
//
//  Created by Артем on 14/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

extension SearchTableViewController {
    func configure(cell: UITableViewCell, with current: CurrentWeatherCity) {
        
        cell.textLabel!.text = current.name
        cell.detailTextLabel?.text = current.sys?.country
        
        let icon = current.weather![0].icon
        
        let url: URL = URL(string: "http://openweathermap.org/img/wn/" + "\(icon!)" + "@2x.png")!
        
        if let imageData = try? Data(contentsOf: url) {
            let image = UIImage(data: imageData)
            cell.imageView?.image = image
        }
    }
}
