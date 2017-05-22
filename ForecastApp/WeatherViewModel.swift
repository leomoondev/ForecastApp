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
    let humidity: String
    let precipitationProbability: String
    let summary: String
    let icon: UIImage
    
    init(model: Weather) {
        let roundedTemperature = Int(model.temperature)
        self.temperature = "\(roundedTemperature)º"
        
        let humidityPercentValue = Int(model.humidity * 100)
        self.humidity = "\(humidityPercentValue)%"
        
        let precipPercentValue = Int(model.precipitationProbability * 100)
        self.precipitationProbability = "\(precipPercentValue)%"
        
        self.summary = model.summary
        
        let weatherInfoPicture = WeatherInfoPicture(iconString: model.icon)
        self.icon = weatherInfoPicture.image
    }
}

