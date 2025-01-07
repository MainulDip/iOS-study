//
//  WeatherManager.swift
//  Clima
//
//  Created by Mainul Dip on 7/6/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherDidUpdateDelegate {
    func weatherDidUpdate(_ weatherModel : WeatherModel) -> Bool
    func didFailWithError (error : Error)
}

struct WeatherManager {
    
    var delegate : WeatherDidUpdateDelegate?
    
    let apiKey = ProcessInfo.processInfo.environment["OPEN_WEATHER"] ?? "Invalid API KEY"
    let baseURL : String = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeatherByCity(_ cityName: String) {
        let urlString = "\(baseURL)?q=\(cityName)&appid=\(apiKey)&units=metric"
        print(urlString)
        
        performNetworkRequest(urlString)
        
        // get the json response, parse/decode into string or weather object
        
        // return the weather object
//        return urlString
    }
    
    func fetchCurrentLocWeather (lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlString = "\(baseURL)?appid=\(apiKey)&units=metric&lat=\(lat)&lon=\(lon)"
        performNetworkRequest(urlString)
    }
    
    // Network Request
    func performNetworkRequest (_ url: String) {
        // do network request, build session and call
        let theURL = URL(string: url)
        let getSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = getSession.dataTask(with: theURL!) { (data, response, error) in
            if error != nil {
                print(error!)
                return (self.delegate?.didFailWithError(error: error!))!
            }
            
            if let safedata = data {
                
                // print the returned data to check
                let dataString = String(data: safedata, encoding: .utf8)
                print(dataString ?? "Nothing Found")
                
                // decode the dataString and convert into WeatherModel
                if let safeWeatherDataParsed = self.perseJson(safedata) {
                    let weatherModel = weatherDataToWeatherModel(safeWeatherDataParsed)
                    print("weatherModel.conditionID" ,weatherModel.weatherConditionGetIcon)
                    print("weatherModel.temperature" ,weatherModel.temperatureSting)
                    if ((self.delegate?.weatherDidUpdate(weatherModel)) == true) {
                        print("delegate?.weatherDidUpdate is called form the weatherManager")
                    }
                }
                
//                print("City Name", weatherDataObj?.name ?? "Error")
//                print("Temp", weatherDataObj?.main.temp! ?? "Error")
//                print("Temp", weatherDataObj?.weather[0].main! ?? "Error")
//
//                if let weatherConditionIcon = weatherDataObj?.weather[0].id {
//                    print("weatherConditionIcon", getWeatherIcon(weatherConditionIcon))
//                }
                
                
            }
            
        }
        
        task.resume()
    }
    
    func perseJson(_ data: Data) -> WeatherData? {
        let jsonDecoder = JSONDecoder()
        var weatherData: WeatherData?
        
        do {
            weatherData = try jsonDecoder.decode(WeatherData.self, from: data)
        } catch {
            print(error)
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
        return weatherData
    }
    
    func weatherDataToWeatherModel (_ weatherD: WeatherData ) -> WeatherModel {
        let cityName = weatherD.name!
        let weatherConditionID = weatherD.weather[0].id!
        let temperature = weatherD.main.temp!
        
        return WeatherModel(conditionID: weatherConditionID, cityName: cityName, temperature: temperature)
    }
}
