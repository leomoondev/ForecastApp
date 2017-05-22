//
//  ViewController.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-16.
//  Copyright © 2017 leomoon. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, CLLocationManagerDelegate, GMSAutocompleteViewControllerDelegate {

    // MARK : Outlets
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var precipationLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var weatherImageIcon: UIImageView!
    // MARK : Variables
    var locationManager = CLLocationManager()
    
    let networkManager = NetworkManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    func locateWithLongtitude(lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        DispatchQueue.main.async() { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            //self.googleMapView.camera = camera
            
            marker.title = "Address : \(title)"
            //marker.map = self.googleMapView
        }
    }
    
    // MARK : CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
       // self.googleMapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    
    // MARK : GoogleAutoComplete Delegate
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        ///self.googleMapView.camera = camera
        fetchWeather(latitue: place.coordinate.latitude, longtitude: place.coordinate.longitude)
        locateWithLongtitude(lon: place.coordinate.longitude, andLatitude: place.coordinate.latitude, andTitle: "HELLO")
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: Found error on Auto Complete \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK : IBAction
    @IBAction func searchButtonTapped(_ sender: Any) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    func displayWeather(using viewModel: WeatherViewModel) {
        currentWeatherLabel.text = viewModel.temperature
        humidityLabel.text = viewModel.humidity
        precipationLabel.text = viewModel.precipitationProbability
        summaryLabel.text = viewModel.summary
        weatherImageIcon.image = viewModel.icon
    }
    
    func fetchWeather(latitue: Double, longtitude: Double ) {
        
        
        //let coordinate = Coordinate(latitude: 37.8267, longitude: -122.4233)
        
        networkManager.getCurrentWeather(at: Coordinate(latitude: latitue, longitude: longtitude)) { [unowned self] currentWeather in
            if let currentWeather = currentWeather {
                let viewModel = WeatherViewModel(model: currentWeather)
                self.displayWeather(using: viewModel)
            }
        }
    }
    
}

