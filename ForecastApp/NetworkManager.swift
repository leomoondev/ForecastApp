//
//  NetworkManager.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

import Foundation

class NetworkManager {

    static let darkSkyAPIKey = "5079a2674db9b6ef9345eb089da4cbbd"
    static let darkSkyURL = "https://api.darksky.net/forecast/\(darkSkyAPIKey)/"

    typealias WeatherCompletionHandler = (Weather?) -> Void

    
    static func getWeatherInformation(withLocation coordinate:String, completion: @escaping ([Weather]) -> ()) {
        
        let url = darkSkyURL + coordinate
        
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather] = []
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForecasts = json["daily"] as? [String:Any] {
                            if let dailyData = dailyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(forecastArray)
            }
        }
        task.resume()
    }
}


