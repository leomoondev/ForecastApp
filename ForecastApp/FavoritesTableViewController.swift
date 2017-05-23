//
//  FavoritesTableViewController.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-22.
//  Copyright © 2017 leomoon. All rights reserved.
//

import UIKit
import GooglePlaces

var numberOfPlacesArray = [String]()
var numberOfCityObject = [Weather]()

class FavoritesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GMSAutocompleteViewControllerDelegate {
    
    //MARK: - Variables
    var noItems:Bool?
    var favoritesStoreObject = [Weather]()
    var favoritesCityNameArray = [String]()
    
    //MARK: - IBOutlet
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        if numberOfPlacesArray.count == 0 {
            
            self.noItems = true
            self.favoritesTableView.reloadData()
        }
        
    }

    //MARK: - UITableView Delegate & Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.noItems == true) {
            return 1
        }
        else {
            
            return numberOfPlacesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoritesTableViewCell
        if (self.noItems == true) {

            return cell
            
        }
        else {
            
            cell.cityNameTextLabel.text = numberOfPlacesArray[indexPath.row]
            return cell
        }
        
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "goToWeatherVC", sender: self);
//
//        let newValue = numberOfCityObject
//        // Create a new variable to store the instance of PlayerTableViewController
//        let destinationVC = WeatherDetailViewController()
//        //destinationVC.receivedValue = newValue
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            if numberOfPlacesArray.count > 0 {
                
                
                numberOfPlacesArray.remove(at: indexPath.row)
                favoritesTableView.reloadData()
                
            } else {
                favoritesTableView.endUpdates()
            }
        }
    }
    
    // MARK: - GoogleAutoComplete Delegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        numberOfPlacesArray.append(place.name)
        self.noItems = false
        favoritesTableView.reloadData()
        fetchWeather(latitue: place.coordinate.latitude, longtitude: place.coordinate.longitude)
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: Found error on Auto Complete \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBAction
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        //self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }

    // MARK: - Helper Method
    func fetchWeather(latitue: Double, longtitude: Double ) {
        
        NetworkManager.getWeatherInformation(withLocation: "\(latitue),\(longtitude)") { (results:[Weather]) in
            for result in results {
                numberOfCityObject.append(result)
                
            }
        }
    }
}
