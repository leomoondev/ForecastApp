//
//  WeatherViewModel.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

import Foundation
import UIKit

struct WeatherViewModel {
    let temperature: String
    let precipitationProbability: String
    let summary: String
    let icon: UIImage
    let windSpeed: String

    
    init(model: Weather) {
        let roundedTemperature = Int(model.temperature)
        self.temperature = "\(roundedTemperature)º"
        
        let windSpeedValue = Int(model.windSpeed * 100)
        self.windSpeed = "\(windSpeedValue)mph"
        
        let precipPercentValue = Int(model.precipitationProbability * 100)
        self.precipitationProbability = "\(precipPercentValue)%"
        
        self.summary = model.summary
        
        let weatherInfoPicture = WeatherInfoPicture(iconString: model.icon)
        self.icon = weatherInfoPicture.image
    }
}

