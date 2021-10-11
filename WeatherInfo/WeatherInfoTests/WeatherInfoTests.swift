//
//  WeatherInfoTests.swift
//  WeatherInfoTests
//
//  Created by Ganesan, Veeramani on 10/7/21.
//

import XCTest
@testable import WeatherInfo

class WeatherInfoTests: XCTestCase {
    private var locationData: WILocationData!
    override func setUpWithError() throws {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFormattingMinMaxTempAndWindSpeed() {
        locationData = WILocationData(id: 4510555176960000, weather_state_name: "Heavy Cloud", weather_state_abbr: "hc", applicable_date: "2021-10-12", min_temp: 15.620000000000001, max_temp: 30.620000000000001, humidity: 80, wind_speed: 4.480849036846153)
        
        let locationDataViewModel = WILocationDataViewModel(locationData: locationData)
        
        XCTAssertEqual(locationDataViewModel.minTemp, "Min: 16°C")
        XCTAssertEqual(locationDataViewModel.maxTemp, "Max: 31°C")
        XCTAssertEqual(locationDataViewModel.windSpeed, "Wind: 4 mph")
    }
    
    func testFormattingHumidity() {
        locationData = WILocationData(id: 4510555176960000, weather_state_name: "Heavy Cloud", weather_state_abbr: "hc", applicable_date: "2021-10-12", min_temp: 15.620000000000001, max_temp: 30.620000000000001, humidity: 80, wind_speed: 4.480849036846153)
        
        let locationDataViewModel = WILocationDataViewModel(locationData: locationData)
        XCTAssertEqual(locationDataViewModel.humidity, "80")
    }
}
