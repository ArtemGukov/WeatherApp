//
//  SearchTableViewController.swift
//  WeatherApp
//
//  Created by Артем on 11/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    //    MARK: - Properties
    
    var searchCities = [CurrentWeatherCity]()
    var url = Url()

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let result = searchCities[indexPath.row]
        
        configure(cell: cell, with: result)
        return cell
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchData()
    }
    
    //    MARK: - Custom methods
    
    func fetchData() {
        let searchTerm = searchBar.text ?? ""
        guard !searchTerm.isEmpty else { return }
        
        let newSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        
        NetworkControllerCurrent.shared.fetchCityData(searchTerm: newSearchTerm) { (searchCity) in
            
            guard searchCity != nil else {
                
                self.searchCities.removeAll()
                return }
            
            DispatchQueue.main.async {
                
                if self.searchCities.contains(where: {$0.name == searchCity?.name}) {

                    print(#line, #function)
                    return
                    
                } else {
                    
                    self.searchCities.removeAll()
                    self.searchCities.append(searchCity!)
                    
                }

                self.tableView.reloadData()
            }
        }
    }
    
    //    MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let identifier = segue.identifier else { return }
        let mainCitiesTableViewController = segue.destination as! MainTableViewController

        if identifier == "saveSegue" {

            guard searchCities.count != 0 else {
                
                print("No available city")
                return }

            if mainCitiesTableViewController.saveCities.contains(where: {$0.name == searchCities[0].name}) {

                print("Double")
            
            } else {

                mainCitiesTableViewController.saveCities.append(searchCities[0])
            }
        }
    }
}
