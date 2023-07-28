//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // Search Fields IBOutlets
    @IBOutlet weak var searchTextField: UITextField!
    // Other IBOutlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    // get the and initialize WeatherManager
    var weatherManager = WeatherManager()
    
    // get the CoreLocation Manager init
    let locationManager = CLLocationManager()
    
    
    @IBAction func updateToCurrentLocation() {
        print("Back To Current Location")
        locationManager.requestLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        // set self as delegate
        searchTextField.delegate = self
        
        // set delegate property of weatherManger to this class, so the weather manager can call weatherDidUpdate method of this class
        weatherManager.delegate = self
        
        // request for location access
        locationManager.requestWhenInUseAuthorization()
        
        // Set Location Manager Delegate, it must come before the requestLocation()
        locationManager.delegate = self
        
        locationManager.requestLocation()
        
       
    }

    @IBAction func btnSearchPressed(_ sender: UIButton) {
        print("The search term is : \(searchTextField?.text ?? "Not yet set")")
        searchTextField.endEditing(true)
        

    }
    
    // good place to track if the user touched anywher else other than the textField or soft keyboard, if so the soft keyboard can be hide or something else to do
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touched or Tapped on the screen, not on the text field or soft keyboard")
        // good time to hide the keyboard if necessary
        searchTextField.endEditing(true)
    }
    
}

//MARK: - Button Delegation
extension WeatherViewController: UITextFieldDelegate {
    // implement the return/go button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("Go Pressed", "Search Value is : \(searchTextField?.text ?? "Not yet set")")
        // do some validation and the return true
        
        // hide the keyboard
        searchTextField.endEditing(true)
        return true
    }
    
    // in lifecycle, if this return true, other function/event will start exequting, otherwise not
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Checking Event from textFieldShouldEndEditing")
        return true
    }
    
    // will call this if textFieldShouldEndEditing returns true
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchText = searchTextField?.text {
            weatherManager.fetchWeatherByCity(searchText)
        }
        
        // get the api key from xcode's scheme
//        if let open_weather =  ProcessInfo.processInfo.environment["OPEN_WEATHER"] {
//            print("OPEN_WEATHER", open_weather)
//        }
//        let theUrl = weatherManager.fetchWeatherByCity("london")
//        print("weatherManager.fetchByCity", theUrl)
        
        // clear the search text
        searchTextField?.text = ""
    }
}

//MARK: -  Delegation
extension WeatherViewController: WeatherDidUpdateDelegate {
    /**
     * Custom function to check and update the weather result on success form the weather manager
     * the weather manager will call this when the api request come back with data after parsing json into swift data
     * weathermanager will use delegate parrtern to access this method form there
     */
    func weatherDidUpdate ( _ weatherModel: WeatherModel) -> Bool {
        
        // check if weather updated or not, return true or false
        
        print("controller.weatherDidUpdate function is called")
        DispatchQueue.main.async {
            self.cityLabel.text = weatherModel.cityName
            self.temperatureLabel.text = weatherModel.temperatureSting
            self.conditionImageView.image = UIImage(systemName: weatherModel.weatherConditionGetIcon)
        }
        
        return true
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Location Manager Delegates
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Calling Location Manager didUpdateLocation")
        
        if let location = locations.last {
            // stop updating weather when it find a locaiton, it will find eventually as this function will be called
            locationManager.stopUpdatingLocation() // Though in my test, requestLocation is working 
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            // call the weatherManger's function providing the params, what will againg update with results
            // by the weatherDidUpdateDelegate's
            weatherManager.fetchCurrentLocWeather(lat: lat, lon: lon)
            print(lat, lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager didFailWithError called")
    }
}

//MARK: - Back To Current Location
//extension WeatherManager: UIViewController {
//
//}
