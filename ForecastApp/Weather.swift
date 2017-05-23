//
//  Weather.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

import Foundation
import UIKit

struct Weather {
    
    let time:Double
    //let icon:String
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
        //self.icon = icon
        self.temperatureMax = temperatureMax
        self.temperatureMin = temperatureMin
        self.windSpeed = windSpeed
        self.precipitationProb = precipitationProb
    }
}



