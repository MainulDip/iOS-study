//
//  WeatherManager.swift
//  Clima
//
//  Created by Mainul Dip on 7/6/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}&units=metric"
    
    func fetchWeatherByCity(_ cityName: String) -> String {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        return urlString
    }
}
