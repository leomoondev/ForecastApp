//
//  NetworkManager.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

import Foundation

class NetworkManager {
    let baseUrl: URL?
    fileprivate let apiKey = "5079a2674db9b6ef9345eb089da4cbbd"
    
    init() {
        
        baseUrl = URL(string: "https://api.darksky.net/forecast/\(apiKey)/")
    }

    typealias WeatherCompletionHandler = (Weather?) -> Void

//    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping WeatherCompletionHandler) {
//        
//        
//        if let url = URL(string: coordinate.description, relativeTo: baseUrl) {
//            let jsonParser = JSONParser(url: url as NSURL)
//            
//            jsonParser.jsonTask {
//                (JSONDictionary) in
//                let currentWeather = self.currentWeatherFromJSON(JSONDictionary)
//                completion(currentWeather)
//            }
//        } else {
//            print("Could not construct a valid URL")
//        }
//    }
    
//    func currentWeatherFromJSON(_ jsonDictionary: [String: AnyObject]?) -> Weather? {
//        var forecastArray:[Weather] = []
//        
//        
//        if let currentWeatherDictionary = jsonDictionary?["daily"] as? [String: AnyObject] {
//            
//            if let dailyWeather = currentWeatherDictionary["data"] as? [[String:Any]] {
//                for dataPoint in dailyWeather {
//                    
////                    if let weatherObject = try? Weather(weatherDictionary: dataPoint as [String : AnyObject]) {
////                        //forecastArray.append(weatherObject)
////                        //print(forecastArray)
////                    }
//                }
//            }
//            return Weather(weatherDictionary: currentWeatherDictionary)
//            
//        }
//        else {
//            print("JSON dictionary returned nil for 'currently' key")
//            return nil
//        }
//    }
//    
}

//struct Coordinate {
//    let latitude: Double
//    let longitude: Double
//    var description: String {
//        return "\(latitude),\(longitude)"
//    }
//}
