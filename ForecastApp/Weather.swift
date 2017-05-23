//
//  Weather.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

//import Foundation
//
//struct Weather {
//    let temperature: Double
//    let precipitationProbability: Double
//    let summary: String
//    let icon: String
//    let windSpeed: Double
//}
//
//extension Weather {
//    
//    struct Key {
//        static let temperature = "temperature"
//        static let precipitationProbability = "precipProbability"
//        static let summary = "summary"
//        static let icon = "icon"
//        static let windSpeed = "windSpeed"
//    }
//    
//    init?(json: [String: AnyObject]) {
//        guard let tempValue = json[Key.temperature] as? Double,
//            let windSpeedValue = json[Key.windSpeed] as? Double,
//            let precipitationProbabilityValue = json[Key.precipitationProbability] as? Double,
//            let summaryString = json[Key.summary] as? String,
//            let iconString = json[Key.icon] as? String else { return nil }
//        
//        self.temperature = tempValue
//        self.windSpeed = windSpeedValue
//        self.precipitationProbability = precipitationProbabilityValue
//        self.summary = summaryString
//        self.icon = iconString
//    }
//}

import Foundation
import UIKit

enum Icon: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    
    func toImage() -> UIImage? {
        var imageName: String
        
        switch self {
        case .ClearDay:
            imageName = "clear-day.png"
        case .ClearNight:
            imageName = "clear-night.png"
        case .Rain:
            imageName = "rain.png"
        case .Snow:
            imageName = "snow.png"
        case .Sleet:
            imageName = "sleet.png"
        case .Wind:
            imageName = "wind.png"
        case .Fog:
            imageName = "fog.png"
        case .Cloudy:
            imageName = "cloudy.png"
        case .PartlyCloudyDay:
            imageName = "cloudy-day.png"
        case .PartlyCloudyNight:
            imageName = "cloudy-night.png"
        }
        
        
        return UIImage(named: imageName)
    }
}

struct Weather {
    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    
    init(weatherDictionary: [String: AnyObject]) {
        temperature = weatherDictionary["temperature"] as? Int
        if let humidityFloat = weatherDictionary["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        if let precipFloat = weatherDictionary["precipProbability"] as? Double {
            precipProbability = Int(precipFloat * 100)
        } else {
            precipProbability = nil
        }
        summary = weatherDictionary["summary"] as? String
        
        if let iconString = weatherDictionary["icon"] as? String,
            let weatherIcon: Icon = Icon(rawValue: iconString){
            icon = weatherIcon.toImage()
        }
    }
}
