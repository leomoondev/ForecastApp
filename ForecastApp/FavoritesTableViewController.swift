//
//  FavoritesTableViewController.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-22.
//  Copyright © 2017 leomoon. All rights reserved.
//

import UIKit
import GooglePlaces

//var favoritesCityNameArray = [String]()

class FavoritesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GMSAutocompleteViewControllerDelegate {

    //let networkManager = NetworkManager()
    var searchResults: [String]!
    var favoritesCityNameArray = [String]()
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//        favoritesTableView.dataSource = self
//        favoritesTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return 1
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        
//        return 1
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return self.searchResults.count
//    }
//    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
//        
//        cell.textLabel?.text = self.searchResults[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("numberOfRowsInSection")
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FavoritesTableViewCell
//        
//        
//        ///cell.cityNameTextLabel?.text = favoritesCityArray[indexPath.row]
//        
////        let favoriteCityName = favoritesCityNameArray[indexPath.row]
////        cell.textLabel?.text =
////        
////        cityNameTextLabel?.text =
//        print("cellForRowAtIndexPath")
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let weatherObject = searchResults[indexPath.section]
        
        cell.textLabel?.text = weatherObject
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
        searchResults.append(place.name)
        favoritesCityArray.append(place.name)
        //cityNameLabel.text = place.name
        fetchWeather(latitue: place.coordinate.latitude, longtitude: place.coordinate.longitude)
        
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

    
    // MARK: - Helper Method
    func displayWeather(using viewModel: Weather) {
        
        //avgTempLabel.text = viewModel.temperature
        //summaryLabel.text = viewModel.summary
        //precipationLabel.text = viewModel.precipitationProbability
        //windSpeedLabel.text = viewModel.windSpeed
        //weatherImageIcon.image = viewModel.icon
    }
    
    func fetchWeather(latitue: Double, longtitude: Double ) {
        
//        networkManager.getCurrentWeather(at: Coordinate(latitude: latitue, longitude: longtitude)) { [unowned self] currentWeather in
//            if let currentWeather = currentWeather {
//                let viewModel = Weather(model: currentWeather)
//                self.displayWeather(using: Weather)
//            }
//        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        //self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }

}
