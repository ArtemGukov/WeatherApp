//
//  ListCitiesTableViewController.swift
//  WeatherApp
//
//  Created by Артем on 05/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

let baseUrl = "https://api.apixu.com/v1/current.json?key="
let tokenId = "e6c5e254947d4d419e6104354190609"

class ListCitiesTableViewController: UITableViewController {

    var cities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter city"
        navigationItem.searchController = searchController
    }

    func fetchCityData(searchTerm: String) {
        
        guard let urlCity = URL(string: baseUrl + tokenId + "&q=" + searchTerm) else {
            print("URL is not correct")
            return
        }
        
        print(#line, #function, urlCity)
        
        URLSession.shared.dataTask(with: urlCity) { (data, _, _)  in
            guard let data = data else { return }
            
            print(#line, #function, data)
            
            do {
                let jsonData = try JSONDecoder().decode(City.self, from: data)
                
                self.cities = [jsonData]
                
                print(#line, #function, data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchData() {
        let searchTerm = navigationItem.searchController?.searchBar.text ?? ""
        if !searchTerm.isEmpty {
            fetchCityData(searchTerm: searchTerm)
            
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
            
                } else {
                    print("No data")
                }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let result = cities[indexPath.row]
        
        configure(cell: cell as! CityTableViewCell, with: result)
        return cell
    }
 

    @IBAction func cancelPressed(_ sender: UIStoryboardSegue) {
        
    }
}

extension ListCitiesTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        fetchData()
        print(#line, #function, "success")
        
    }
}


extension ListCitiesTableViewController {
    func configure(cell: CityTableViewCell, with city: City) {
 
        cell.nameLabel.text = city.location.name
        cell.regionLabel.text = city.location.region
        cell.tempLabel.text = city.current.temp_c?.description
        
        let url: URL = URL(string: "http:\(city.current.condition.icon)")!
        
        if let imageData = try? Data(contentsOf: url) {
            let image = UIImage(data: imageData)
            cell.iconImage.image = image
        }
    }
}
