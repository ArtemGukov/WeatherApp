//
//  DetailCityViewController.swift
//  WeatherApp
//
//  Created by Артем on 05/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class DetailCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //    MARK: - Properties
    
    var currentWeather: CurrentWeatherCity!
    var forecastWeather = [ForecastWeatherCity]()
    var url = Url()
    
    //    MARK: - Outlets
    
    @IBOutlet weak var segmentControlWeather: UISegmentedControl!
    
    @IBOutlet weak var tableViewForecast: UITableView!
    @IBOutlet weak var stackviewCurrent: UIStackView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nowTempLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var pressureImage: UIImageView!
    @IBOutlet weak var windImage: UIImageView!
    @IBOutlet weak var humidityImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI(cityName: currentWeather.name!)
        
        tableViewForecast.isHidden = true
        stackviewCurrent.isHidden = false
    }
    
    //    MARK: - Custom methods

    func updateUI(cityName: String) {
        
        let newSearchTerm = cityName.replacingOccurrences(of: " ", with: "%20")

        switch segmentControlWeather.selectedSegmentIndex {
        case 0:
            configureCurrentUI()
    
        case 1:
            tableViewForecast.isHidden = false
            stackviewCurrent.isHidden = true
            
            NetworkController.shared.fetchCityDataForecast(searchTerm: newSearchTerm) { (forecastWeather) in
                
                DispatchQueue.main.async {
                    
                    self.forecastWeather.append(forecastWeather!)
                    self.tableViewForecast.reloadData()
                }
            }
            
        default:
            break
        }
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        var data: Int = 0
        for i in forecastWeather {
            data =  i.list!.count
        }
        
        return data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath)
        
        for i in forecastWeather {
            let result = i.list![indexPath.row]
            configureForecastUI(cell: cell, with: result)
        }
        
        return cell
    }
    
    //    MARK: - IBActions
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        
        updateUI(cityName: currentWeather.name!)
    }
}
