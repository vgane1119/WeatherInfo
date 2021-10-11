//
//  WIServiceManager.swift
//  WeatherInfo
//
//  Created by Ganesan, Veeramani on 10/10/21.
//

//WIServiceManager - Service maanger to send requet and receive data from / to server. It supports "GET" method calls and returns the result via completion handler

import Foundation

class WIServiceManager {
    static let weatherAPIbaseURL = "https://www.metaweather.com"
    
    func sendRequest(withUrl url: String, andCompletionHandler handler: @escaping (_ data: Data?, _ error: Error?)-> Void)
    {
       let request = self.prepareRequest(withUrl: url)
        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            if (response as? HTTPURLResponse) != nil {
                if let httpData = data {
                    handler(httpData, nil)
                }
            }
            else {
                handler(nil, self?.errorForMessage(message: "Invalid Response"))
            }
        }).resume()
    }

    private func prepareRequest(withUrl url: String)-> (URLRequest) {
        var endPointUrl = WIServiceManager.weatherAPIbaseURL + url
        endPointUrl = endPointUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let urlRequest = URLRequest(url: URL(string: endPointUrl)!)
        return urlRequest
    }
    
    private func errorForMessage(message: String)->Error {
        return NSError(domain: "com.self.WeatherInfo", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
