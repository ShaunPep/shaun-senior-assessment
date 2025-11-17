//
//  CurrentWeather.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/15.
//

import Foundation

enum WeatherCondictionType: String {
    case partlyCloudy = "cloud.sun"
    case raining = "cloud.rain"
    case clear = "sun.max"
    case cloudy = "cloud"
    case heavyRain = "cloud.heavyrain"
    case hail = "cloud.hail"
    case none = "nosign"
}

struct Weather: Decodable {
    let current: Current
    
    var displayTempreture: String {
        return current.tempC.toDegressCelcius()
    }
    
    var weatherConditionDisplayIcon: WeatherCondictionType {
        switch current.condition.code {
        case 1000:
            return .clear
        case 1003:
            return .partlyCloudy
        case 1006:
            return .cloudy
        case 1009:
            return .cloudy
        case 1153, 1183:
            return .raining
        case 1189, 1195:
            return .heavyRain
        case 1237, 1261:
            return .hail
        default:
            return .none
        }
    }
}

struct Current: Decodable {
    let tempC: Double
    let condition: WeatherCondition
}

struct WeatherCondition: Decodable {
    let code: Int
}
