//
//  WILocationDataViewModel.swift
//  WeatherInfo
//
//  Created by Ganesan, Veeramani on 10/10/21.
//

//WILocationDataViewModel - This class formats the model object contents for an view to display it. This class is a part of MVVM architecture

import UIKit

class WILocationDataViewModel {
    private let locationData: WILocationData
    
    public init(locationData: WILocationData) {
        self.locationData = locationData
    }
    
    public var stateName: String {
        return locationData.weather_state_name
    }
    
    public var minTemp: String {
        return "Min: " + String(Int(round(locationData.min_temp))) + "°C"
    }
    
    public var maxTemp: String {
        return "Max: " + String(Int(round(locationData.max_temp))) + "°C"
    }
    
    public var humidity: String {
        return "Hum: " + String(locationData.humidity)
    }
    
    public var windSpeed: String {
        return "Wind: " + String(Int(round(locationData.wind_speed))) + " mph"
    }
    
    public var date: String {
        return locationData.applicable_date
    }
    
    public func loadStateImage(stateImage: @escaping (UIImage?) -> ()) {
        let stateAbbr = locationData.weather_state_abbr
        AsyncImageLoad(withURL: "https://www.metaweather.com/static/img/weather/ico/" + stateAbbr + ".ico").loadImage(imgData: { image, error in
            guard let image = image, error == nil else { return stateImage(nil) }
            stateImage(image)
        })
    }
}
