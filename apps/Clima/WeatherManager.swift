//
//  WeatherManager.swift
//  Clima
//
//  Created by Mainul Dip on 7/6/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let apiKey = ProcessInfo.processInfo.environment["OPEN_WEATHER"] ?? "Invalid API KEY"
    let baseURL : String = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeatherByCity(_ cityName: String) -> String {
        let urlString = "\(baseURL)?q=\(cityName)&appid=\(apiKey)&units=metric"
        print(urlString)
        
        // do network request, build session and call
        let theURL = URL(string: urlString)
        let getSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = getSession.dataTask(with: theURL!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if let safedata = data {
                
                // print the returned data to check
                let dataString = String(data: safedata, encoding: .utf8)
                print(dataString ?? "Nothing Found")
                
                // decode the dataString
                let weatherDataObj = self.perseJson(safedata)
                
                print("City Name", weatherDataObj.name)
            }
            
        }
        
        task.resume()
        
        // get the json response, parse/decode into string or weather object
        
        // return the weather object
        return urlString
    }
    
    func perseJson(_ data: Data) -> WeatherData {
        let jsonDecoder = JSONDecoder()
        var weatherData: WeatherData?
        
        do {
            weatherData = try jsonDecoder.decode(WeatherData.self, from: data)
        } catch {
            print(error)
        }
        
        return weatherData!
    }
}
