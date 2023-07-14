//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    // Search Fields IBOutlets
    @IBOutlet weak var searchTextField: UITextField!
    // Other IBOutlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    // get the WeatherManager
    let weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
            
        // set self as delegate
        searchTextField.delegate = self
    }

    @IBAction func btnSearchPressed(_ sender: UIButton) {
        print("The search term is : \(searchTextField?.text ?? "Not yet set")")
        searchTextField.endEditing(true)
        

    }
    
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
        print("Checking Event")
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
        let theUrl = weatherManager.fetchWeatherByCity("london")
        print("weatherManager.fetchByCity", theUrl)
        
        // clear the search text
        searchTextField?.text = ""
    }
    
    // good place to track if the user touched anywher else other than the textField or soft keyboard, if so the soft keyboard can be hide or something else to do
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touched or Tapped on the screen, not on the text field or soft keyboard")
        // good time to hide the keyboard if necessary
        searchTextField.endEditing(true)
    }
    
}

