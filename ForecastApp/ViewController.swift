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

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {

    // MARK : Outlets
    //@IBOutlet weak var googleMapView: GMSMapView!
    
    // MARK : Variables
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        initGoogleMaps()
    }

    func initGoogleMaps() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        //self.googleMapView.camera = camera
        //googleMapView = mapView
        
        //self.googleMapView.delegate = self
//        self.googleMapView.isMyLocationEnabled = true
//        self.googleMapView.settings.myLocationButton = true
//        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
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

//    // MARK : GMSMapView Delegate
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        //self.googleMapView.isMyLocationEnabled = true
//    }
//    
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        //self.googleMapView.isMyLocationEnabled = true
//        if(gesture) {
//            mapView.selectedMarker = nil
//        }
//    }
    
    // MARK : GoogleAutoComplete Delegate
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        ///self.googleMapView.camera = camera
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
    
}

