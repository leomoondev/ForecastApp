//
//  WeatherDetailViewController.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-23.
//  Copyright © 2017 leomoon. All rights reserved.
//

import UIKit
import GooglePlaces

class WeatherDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GMSAutocompleteViewControllerDelegate {
    
    
    @IBOutlet weak var detailTableView: UITableView!
    var noItems:Bool?
    
    var numberOfPlacesArray = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        if self.numberOfPlacesArray.count == 0 {
            
            self.noItems = true
            self.detailTableView.reloadData()
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    // MARK: - GoogleAutoComplete Delegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //cityNameLabel.text = place.name
        fetchWeather(latitude: place.coordinate.latitude, longtitude: place.coordinate.longitude)
        
        //appTitleLabel.isHidden = true
        //informationLabel.isHidden = true
        
        //tempTitleLabel.isHidden = false
        //summaryTitleLabel.isHidden = false
        //windTitleLabel.isHidden = false
        //precipitationTitleLabel.isHidden = false
        
        //addToFavoritesButton.isHidden = false
        //removeFromFavoritesButton.isHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: Found error on Auto Complete \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchWeather(latitude: Double, longtitude: Double ) {
        
        //        networkManager.getCurrentWeather(at: Coordinate(latitude: latitue, longitude: longtitude)) { [unowned self] currentWeather in
        //            if let currentWeather = currentWeather {
        //                let viewModel = Weather(model: currentWeather)
        //                self.displayWeather(using: viewModel)
        //            }
        //        }
        
        //        let networkManager = NetworkManager()
        //        networkManager.getCurrentWeather(at: Coordinate(latitude: latitue, longitude: longtitude)) {
        //            (currentWeather) in
        //            if let currentWeather = currentWeather {
        //                DispatchQueue.main.async {
        //                    if let temperature = currentWeather.temperature {
        //                        self.avgTempLabel?.text = "\(temperature)º"
        //                    }
        ////                    if let humidity = currentWeather.humidity {
        ////                        self.windSpeedLabel?.text = "\(humidity)%"
        ////                    }
        ////                    if let precipitation = currentWeather.precipProbability {
        ////                        self.precipationLabel?.text = "\(precipitation)%"
        ////                    }
        //                    if let icon = currentWeather.icon {
        //                        self.weatherImageIcon?.image = icon
        //                    }
        //                    if let summary = currentWeather.summary {
        //                        self.summaryLabel?.text = summary
        //                    }
        //
        //                }
        //            }
        //        }
        
        Weather.forecast(withLocation: "\(latitude),\(longtitude)") { (results:[Weather]) in
            for result in results {
                
                self.numberOfPlacesArray.append(result)
                
                print("\(result)\n\n")
            }
        }
    }
    
    //MARK: - TableView Delegate & Data Source -
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.noItems == true) {
            return 1
        } else {
            
            return self.numberOfPlacesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailCell", for: indexPath) as! WeatherDetailTableViewCell
        if (self.noItems == true) {
            
            //            let noPartyItems = PartyItem.init(name: "No Party Items", goal: 0, image: #imageLiteral(resourceName: "sadClown"), itemEventID: "hostingEvent", amountFunded: 0)
            //            cell.configureCellWithSadClown(partyItem: noPartyItems)
            return cell
            
        } else {
            
            //            cell.configureCellWithPartyItem(partyItem: self.numberOfPartyItemsArray[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "goToWeatherVC", sender: indexPath);
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}



