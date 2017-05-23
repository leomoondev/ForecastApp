//
//  WeatherDetailViewController.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-23.
//  Copyright © 2017 leomoon. All rights reserved.
//

import UIKit
import GooglePlaces

class WeatherDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: = IBOutlet
    @IBOutlet weak var detailTableView: UITableView!
    
    // MARK: = Variable
    var numberOfPlacesArray = [Weather]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        if self.numberOfPlacesArray.count == 0 {
            
            self.detailTableView.reloadData()
        }
    }
    
    // MARK: - UITableView Delegate & Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return numberOfCityObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailCell", for: indexPath) as! WeatherDetailTableViewCell

        print(numberOfCityObject)


        let composition = numberOfCityObject[indexPath.row]

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        cell.dayTimeLabel.text = dateFormatter.string(from: (NSDate(timeIntervalSince1970: composition.time)) as Date)
        
        cell.temperatureMaxLabel.text = "\(round(convertToCelsius(fahrenheit: composition.temperatureMax) * 4.0)/4.0)º"
        cell.temperatureMinLabel.text = "\(round(convertToCelsius(fahrenheit: composition.temperatureMin) * 4.0)/4.0)º"
        cell.windSpeedLabel.text = "\(composition.windSpeed)mph"
        cell.precipitationLabel.text = "\(composition.precipitationProb*100)%"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }

    // MARK: - Helper Method
    func fetchWeather(latitude: Double, longtitude: Double ) {
        NetworkManager.getWeatherInformation(withLocation: "\(latitude),\(longtitude)") { (results:[Weather]) in
            for result in results {
                
                self.numberOfPlacesArray.append(result)
            }
        }

    }
    func convertToCelsius(fahrenheit: Double) -> Double {
        return Double(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
}
