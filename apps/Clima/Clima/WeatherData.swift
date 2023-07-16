//
//  WeatherData.swift
//  Clima
//
//  Created by Mainul Dip on 7/14/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String?
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?
}

struct Weather: Decodable {
    let id: Int?
    let main, description, icon: String?
}
