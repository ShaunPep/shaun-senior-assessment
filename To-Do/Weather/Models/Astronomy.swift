//
//  Astronomy.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/15.
//

import Foundation

struct WeatherAstronomy: Decodable {
    let astronomy: Astronomy
    
    var displaySunrise: String {
        return astronomy.astro.sunrise
    }
    
    var displaySunset: String {
        return astronomy.astro.sunset
    }
}

struct Astronomy: Decodable {
    let astro: Astro
}

struct Astro: Decodable {
    let sunrise: String
    let sunset: String
}
