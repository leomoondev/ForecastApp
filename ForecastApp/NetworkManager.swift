//
//  NetworkManager.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

import Foundation

class NetworkManager {
    let darkSkyAPIKey: String
    let baseUrl: URL?
    //fileprivate let apiKey = "5079a2674db9b6ef9345eb089da4cbbd"
    
//    lazy var baseUrl: URL = {
//        return URL(string: "https://api.darksky.net/forecast/\(self.apiKey)/")!
//    }()
//
    
    init(apiKey: String) {
        darkSkyAPIKey = apiKey
        baseUrl = URL(string: "https://api.darksky.net/forecast/\(darkSkyAPIKey)/")
    }
    //let downloader = JSONParser()

    typealias WeatherCompletionHandler = (Weather?) -> Void

    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping WeatherCompletionHandler) {
        
//        guard let url = URL(string: coordinate.description, relativeTo: baseUrl) else {
//            completion(nil)
//            return
//        }
//        
//        let request = URLRequest(url: url)
//        
//        let task = downloader.jsonTask(with: request) { json in
//            
//            DispatchQueue.main.async {
//                guard let json = json else {
//                    completion(nil)
//                    return
//                }
//                
//                guard let currentWeatherJson = json["currently"] as? [String: AnyObject], let currentWeather = Weather(json: currentWeatherJson) else {
//                    completion(nil)
//                    return
//                }
//                completion(currentWeather)
//            }
//        }
//        task.resume()
        
        if let url = URL(string: coordinate.description, relativeTo: baseUrl) {
            let jsonParser = JSONParser(url: url as NSURL)
            
            jsonParser.jsonTask {
                (JSONDictionary) in
                let currentWeather = self.currentWeatherFromJSON(JSONDictionary)
                completion(currentWeather)
            }
        } else {
            print("Could not construct a valid URL")
        }
    }
    
    func currentWeatherFromJSON(_ jsonDictionary: [String: AnyObject]?) -> Weather? {
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
            return Weather(weatherDictionary: currentWeatherDictionary)
        } else {
            print("JSON dictionary returned nil for 'currently' key")
            return nil
        }
    }
    
}

struct Coordinate {
    let latitude: Double
    let longitude: Double
    var description: String {
        return "\(latitude),\(longitude)"
    }
}
