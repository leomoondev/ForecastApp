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
            imageName = "cloudy-night.png"
        }
        
        return UIImage(named: imageName)
    }
}
struct Weather {
    
    let time:Double
    //let icon:String
    var icon: UIImage? = UIImage(named: "default.png")
    let temperatureMax:Double
    let temperatureMin:Double
    let windSpeed:Double
    let precipitationProb:Double
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        
        guard let time = json["time"] as? Double else {throw SerializationError.missing("time is missing")}
        //guard let icon = json["icon"] as? String else {throw SerializationError.missing("icon is missing")}
        guard let temperatureMax = json["temperatureMax"] as? Double else {throw SerializationError.missing("tempMax is missing")}
        guard let temperatureMin = json["temperatureMin"] as? Double else {throw SerializationError.missing("tempMin is missing")}
        guard let windSpeed = json["windSpeed"] as? Double else {throw SerializationError.missing("windSpeed is missing")}
        guard let precipitationProb = json["precipProbability"] as? Double else {throw SerializationError.missing("precipProb is missing")}

        self.time = time
        if let iconString = json["icon"] as? String,
            let weatherIcon: WeatherIcon = WeatherIcon(rawValue: iconString){
            icon = weatherIcon.toImage()
        }
        self.temperatureMax = temperatureMax
        self.temperatureMin = temperatureMin
        self.windSpeed = windSpeed
        self.precipitationProb = precipitationProb
    }
}



