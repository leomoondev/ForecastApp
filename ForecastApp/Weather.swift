//
//  Weather.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

import Foundation
import UIKit

enum WeatherIcon: String {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain = "rain"
    case snow = "snow"
    case sleet = "sleet"
    case wind = "wind"
    case fog = "fog"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    
    func toImage() -> UIImage? {
        var imageName: String
        
        switch self {
        case .clearDay:
            imageName = "clear-day.png"
        case .clearNight:
            imageName = "clear-night.png"
        case .rain:
            imageName = "rain.png"
        case .snow:
            imageName = "snow.png"
        case .sleet:
            imageName = "sleet.png"
        case .wind:
            imageName = "wind.png"
        case .fog:
            imageName = "fog.png"
        case .cloudy:
            imageName = "cloudy.png"
        case .partlyCloudyDay:
            imageName = "cloudy-day.png"
        case .partlyCloudyNight:
            imageName = "cloudyå-night.png"
        }
        
        return UIImage(named: imageName)
    }
}

//struct Weather {
//    let temperature: Int?
//    let humidity: Int?
//    let precipProbability: Int?
//    let summary: String?
//    var icon: UIImage? = UIImage(named: "default.png")
//    
//    init(weatherDictionary: [String: AnyObject]) {
//        temperature = weatherDictionary["temperature"] as? Int
//        if let humidityFloat = weatherDictionary["humidity"] as? Double {
//            humidity = Int(humidityFloat * 100)
//        } else {
//            humidity = nil
//        }
//        if let precipFloat = weatherDictionary["precipProbability"] as? Double {
//            precipProbability = Int(precipFloat * 100)
//        } else {
//            precipProbability = nil
//        }
//        summary = weatherDictionary["summary"] as? String
//        
//        if let iconString = weatherDictionary["icon"] as? String,
//            let weatherImage: WeatherIcon = WeatherIcon(rawValue: iconString){
//            icon = weatherImage.toImage()
//        }
//    }
//}




struct Weather {
    let time:Double
    let icon:String
    let temperatureMax:Double
    let temperatureMin:Double
    let windSpeed:Double
    let precipitationProb:Double
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
       // guard let summary = json["summary"] as? String else {throw SerializationError.missing("summary is missing")}
        guard let time = json["time"] as? Double else {throw SerializationError.missing("time is missing")}
        

        guard let icon = json["icon"] as? String else {throw SerializationError.missing("icon is missing")}
        
        guard let temperatureMax = json["temperatureMax"] as? Double else {throw SerializationError.missing("tempMax is missing")}
        guard let temperatureMin = json["temperatureMin"] as? Double else {throw SerializationError.missing("tempMin is missing")}
        guard let windSpeed = json["windSpeed"] as? Double else {throw SerializationError.missing("windSpeed is missing")}
        guard let precipitationProb = json["precipProbability"] as? Double else {throw SerializationError.missing("precipProb is missing")}

        self.time = time
        self.icon = icon
        self.temperatureMax = temperatureMax
        self.temperatureMin = temperatureMin
        self.windSpeed = windSpeed
        self.precipitationProb = precipitationProb
        
    }
    
    
    static let basePath = "https://api.darksky.net/forecast/5079a2674db9b6ef9345eb089da4cbbd/"

    static func forecast (withLocation location:String, completion: @escaping ([Weather]) -> ()) {
        
        let url = basePath + location
        
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
                                        print(forecastArray)
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

struct Coordinate {
    let latitude: Double
    let longitude: Double
    var description: String {
        return "\(latitude),\(longitude)"
    }
}

