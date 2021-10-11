//
//  WILocationData.swift
//  WeatherInfo
//
//  Created by Ganesan, Veeramani on 10/10/21.
//

import Foundation

struct WILocationData: Codable {
    let id: UInt
    let weather_state_name: String
    let weather_state_abbr: String
    let applicable_date: String
    let min_temp: Float
    let max_temp: Float
    let humidity: UInt
    let wind_speed: Float
}
