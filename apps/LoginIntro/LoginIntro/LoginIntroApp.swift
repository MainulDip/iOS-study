//
//  LoginIntroApp.swift
//  LoginIntro
//
//  Created by kaka beautha on 5/9/23.
//

import SwiftUI

var isUserLoggedIn : Bool = false;

@main
struct LoginIntroApp: App {
    var body: some Scene {
        WindowGroup {
            if isUserLoggedIn {
                MainView()
            } else {
                LoginUIView()
            }
        }
    }
}
