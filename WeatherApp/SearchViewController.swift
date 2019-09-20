//
//  SearchTableViewController.swift
//  WeatherApp
//
//  Created by Артем on 11/09/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate {
    
    //    MARK: - Properties
    let locationManager = CLLocationManager()
    
    var searchCities = [CurrentWeatherCity]()
    var url = Url()

    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonMyLocation: UIButton!
    @IBOutlet weak var tableViewSearch: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
        searchBar.delegate = self
    }
    
    //    MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let result = searchCities[indexPath.row]
        
        configure(cell: cell, with: result)
        return cell
    }
    
    //    MARK: - Search bar data source

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        guard !searchTerm.isEmpty else { return }
        
        print(#line, #function)
        fetchData(searchTerm: searchTerm)
    }
    
    //    MARK: - Custom methods
    
    func updateUI() {
        
        switch segmentedController.selectedSegmentIndex {
        case 0:
            searchBar.isHidden = false
            buttonMyLocation.isHidden = true
            searchCities.removeAll()
            
        case 1:
            searchBar.isHidden = true
            buttonMyLocation.isHidden = false
            searchCities.removeAll()
            
        default:
            break
        }
        
        tableViewSearch.reloadData()
    }
    
    func fetchData(searchTerm: String) {
        
        let newSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        
        NetworkController.shared.fetchCityDataCurrent(searchTerm: newSearchTerm) { (searchCity) in
            
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

                self.tableViewSearch.reloadData()
                
            }
        }
    }
    
    //    MARK: - Location methods
    
    func determineMyCurrentLocation() {

        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            print(#line, #function)

        } else {
            print("error")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0] as CLLocation
        
        fetchCity(from: userLocation) { (city, error) in
            guard let city = city, error == nil else { return }
            
            self.locationManager.stopUpdatingLocation()
            self.fetchData(searchTerm: city)
        }
    }
    
    func fetchCity(from location: CLLocation, completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       error)
            
        }
    }
    
    //    MARK: - Keyboard method
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
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
    
    //    MARK: - IBActions
    
    @IBAction func segmentControllerPressed(_ sender: UISegmentedControl) {
        
        updateUI()
    }
    
    @IBAction func buttonMyLocayionPressed(_ sender: UIButton) {
        
        determineMyCurrentLocation()
    }
}
