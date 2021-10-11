//
//  WILocationService.swift
//  WeatherInfo
//
//  Created by Ganesan, Veeramani on 10/10/21.
//

// WILocationService - This class determins whether the location data has to be refreshed or not. If needed it can send request to the server and get updated weather data for a given location.

import Foundation

class WILocationService {
    static let sharedLocationService = WILocationService()
    
    func doRefersh(lastUpdated: TimeInterval?) -> Bool {
        //Refersh interval every 1 Hour
        guard let lastUpdated = lastUpdated, (Date().timeIntervalSince1970 - lastUpdated) > (20) else {
            return false
        }
        return true
    }
    
    func fetchData(forLocationWOEId locationWOEId: String, withCompletionHandler handler: @escaping ([WILocationData]?) -> Void) {
        WIServiceManager().sendRequest(withUrl: "/api/location/" + locationWOEId + "/") { [weak self] data, error in
            if error != nil {
                print ("LocationService Fetch Error: \(String(describing: error))")
                handler(nil)
            }
            else {
                guard let data = data else { return handler(nil) }
                handler(self?.parseData(response: data))
            }
        }
    }
    
    func parseData(response: Data) -> [WILocationData]? {
        do {
            let dictFromJSON = try JSONSerialization.jsonObject(with: response, options: .allowFragments) as! [String:Any]
            let jsonItems = dictFromJSON["consolidated_weather"] as? NSArray
            let jsonData = try JSONSerialization.data(withJSONObject: jsonItems!, options: [])
            let locationData = try JSONDecoder().decode([WILocationData].self, from: jsonData)
            return locationData
        }
        catch {
            print("LocationService Parser Error!!!")
            return nil
        }
    }
}
