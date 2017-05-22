//
//  NetworkManager.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

import Foundation

class NetworkManager {
    fileprivate let apiKey = "5079a2674db9b6ef9345eb089da4cbbd"
    
    lazy var baseUrl: URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.apiKey)/")!
    }()
    
    let downloader = JSONParser()
    
    //typealias CurrentWeatherCompletionHandler = (CurrentWeather?, DarkSkyError?) -> Void
    typealias WeatherCompletionHandler = (Weather?) -> Void
    //typealias JSON = [String: AnyObject]
    
    //typealias JSONTaskCompletionHandler = (JSON?, DarkSkyError?) -> Void
    //typealias JSONDictionaryCompletion = (JSON?) -> Void
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping WeatherCompletionHandler) {
        
        guard let url = URL(string: coordinate.description, relativeTo: baseUrl) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: request) { json in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil)
                    return
                }
                
                guard let currentWeatherJson = json["currently"] as? [String: AnyObject], let currentWeather = Weather(json: currentWeatherJson) else {
                    completion(nil)
                    return
                }
                
                completion(currentWeather)
            }
        }
        
        task.resume()
        
    }
}

struct Coordinate {
    let latitude: Double
    let longitude: Double
    var description: String {
        return "\(latitude),\(longitude)"
    }
}
