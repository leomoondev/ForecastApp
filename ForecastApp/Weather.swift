//
//  Weather.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-21.
//  Copyright © 2017 leomoon. All rights reserved.
//

import Foundation

struct Weather {
    let temperature: Double
    let precipitationProbability: Double
    let summary: String
    let icon: String
    let windSpeed: Double
}

extension Weather {
    
    struct Key {
        static let temperature = "temperature"
        static let precipitationProbability = "precipProbability"
        static let summary = "summary"
        static let icon = "icon"
        static let windSpeed = "windSpeed"
    }
    
    init?(json: [String: AnyObject]) {
        guard let tempValue = json[Key.temperature] as? Double,
            let windSpeedValue = json[Key.windSpeed] as? Double,
            let precipitationProbabilityValue = json[Key.precipitationProbability] as? Double,
            let summaryString = json[Key.summary] as? String,
            let iconString = json[Key.icon] as? String else { return nil }
        
        self.temperature = tempValue
        self.windSpeed = windSpeedValue
        self.precipitationProbability = precipitationProbabilityValue
        self.summary = summaryString
        self.icon = iconString
    }
}

