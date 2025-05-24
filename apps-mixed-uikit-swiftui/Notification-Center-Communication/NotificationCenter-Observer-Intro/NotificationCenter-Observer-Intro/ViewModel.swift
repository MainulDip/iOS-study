//
//  ViewModel.swift
//  NotificationCenter-Observer-Intro
//
//  Created by Mainul Dip on 5/18/25.
//

import Foundation

class ViewModel {
    
    let light = Notification.Name(K.NotificationKeys.lightNotificationKey)
    let dark = Notification.Name(K.NotificationKeys.darkNotificationKey)
    
    init() {
        print("ViewModel Initialized")
        createObserver()
    }
    
    // Create all Notificatin Observers at single shot
    func createObserver () {
        // LightButton Observer
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterInage(notification:)), name: light, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNameLabel(notification:)), name: light, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackgroundColor(notification:)), name: light, object: nil)
        
        // DarkButton Observer
        NotificationCenter.default.addObserver(self, selector: #selector(updateCharacterInage(notification:)), name: dark, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNameLabel(notification:)), name: dark, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackgroundColor(notification:)), name: dark, object: nil)

    }
    
    @objc func updateCharacterInage(notification: Notification) {
        let isLight = notification.name == light
        if (isLight) {
            print("light button is pressed")
        } else {
            print("dark buttton is pressed")
        }
    }
    
    @objc func updateNameLabel(notification: Notification) {
        let isLight = notification.name == light
        if (isLight) {
            print("Change label to light")
        } else {
            print("Change label to dark")
        }
    }
    
    @objc func updateBackgroundColor(notification: Notification) {
        let isLight = notification.name == light
        if (isLight) {
            print("Now the BG is light")
        } else {
            print("Now the BG is dark")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("ViewModel DeInitialized")
    }
}
