//
//  ViewController.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-16.
//  Copyright © 2017 leomoon. All rights reserved.
//

import UIKit
import GooglePlaces

class WeatherViewController: UIViewController, CLLocationManagerDelegate, GMSAutocompleteViewControllerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!

    @IBOutlet weak var avgTempLabel: UILabel!
    @IBOutlet weak var precipationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherImageIcon: UIImageView!
    
    @IBOutlet weak var tempTitleLabel: UILabel!
    @IBOutlet weak var summaryTitleLabel: UILabel!
    @IBOutlet weak var windTitleLabel: UILabel!
    @IBOutlet weak var precipitationTitleLabel: UILabel!
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    
    @IBOutlet weak var addToFavoritesButton: UIButton!
    @IBOutlet weak var removeFromFavoritesButton: UIButton!
    
    // MARK: - Variables
    var locationManager = CLLocationManager()
    
    let networkManager = NetworkManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tempTitleLabel.isHidden = true
        summaryTitleLabel.isHidden = true
        windTitleLabel.isHidden = true
        precipitationTitleLabel.isHidden = true
        
        addToFavoritesButton.isHidden = true
        removeFromFavoritesButton.isHidden = true
    }
    

    // MARK: - CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.locationManager.stopUpdatingLocation()
    }
    
    // MARK: - GoogleAutoComplete Delegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        cityNameLabel.text = place.name
        fetchWeather(latitue: place.coordinate.latitude, longtitude: place.coordinate.longitude)
        
        appTitleLabel.isHidden = true
        informationLabel.isHidden = true
        
        tempTitleLabel.isHidden = false
        summaryTitleLabel.isHidden = false
        windTitleLabel.isHidden = false
        precipitationTitleLabel.isHidden = false
        
        addToFavoritesButton.isHidden = false
        removeFromFavoritesButton.isHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: Found error on Auto Complete \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper Method
    func displayWeather(using viewModel: WeatherViewModel) {
        avgTempLabel.text = viewModel.temperature
        summaryLabel.text = viewModel.summary
        precipationLabel.text = viewModel.precipitationProbability
        windSpeedLabel.text = viewModel.windSpeed
        weatherImageIcon.image = viewModel.icon
    }
    
    func fetchWeather(latitue: Double, longtitude: Double ) {
        
        networkManager.getCurrentWeather(at: Coordinate(latitude: latitue, longitude: longtitude)) { [unowned self] currentWeather in
            if let currentWeather = currentWeather {
                let viewModel = WeatherViewModel(model: currentWeather)
                self.displayWeather(using: viewModel)
            }
        }
    }
    
    // MARK: - IBAction
    @IBAction func searchButtonTapped(_ sender: Any) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    @IBAction func addToFavoritesButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func removeFromFavoritesButtonTapped(_ sender: Any) {
        
    }
    
}
