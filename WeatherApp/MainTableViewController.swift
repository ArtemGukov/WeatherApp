//
//  ListCitiesTableViewController.swift
//  WeatherApp
//
//  Created by Артем on 05/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    //let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    var saveCities = [CurrentWeatherCity]()
    var url = Url()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSample(searchTerm: "saint petersburg")
        loadSample(searchTerm: "moscow")
        loadSample(searchTerm: "madrid")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func loadSample(searchTerm: String) {
        
        let newSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        
        NetworkControllerCurrent.shared.fetchCityData(searchTerm: newSearchTerm) { (saveCities) in
            if let saveCities = saveCities {
                self.updateUI(with: [saveCities])
            }
        }
    }
    
    func updateUI(with saveCities: [CurrentWeatherCity]) {
        
        DispatchQueue.main.async {
            
            self.saveCities.append(contentsOf: saveCities)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return saveCities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let result = saveCities[indexPath.row]
    
        configure(cell: cell as! CityMainTableViewCell, with: result)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detailSegue" else { return }
        guard let controller = segue.destination as? DetailCityViewController else { return }
        
        if let cityIndex = tableView.indexPathForSelectedRow?.row {
            controller.currentWeather = saveCities[cityIndex]
                        
        }
    }
 
    @IBAction func cancelPressed(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func savePressed(_ sender: UIStoryboardSegue) {
        
    }
}



