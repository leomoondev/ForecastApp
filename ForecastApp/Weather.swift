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
            let weatherImage: WeatherIcon = WeatherIcon(rawValue: iconString){
            icon = weatherImage.toImage()
        }
    }
}
