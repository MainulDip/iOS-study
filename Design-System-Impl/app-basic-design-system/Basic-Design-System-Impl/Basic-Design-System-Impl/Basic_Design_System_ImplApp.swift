//
//  Basic_Design_System_ImplApp.swift
//  Basic-Design-System-Impl
//
//  Created by Mainul Dip on 9/4/25.
//

import SwiftUI

@main
struct Basic_Design_System_ImplApp: App {
    
    init () {
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    performAsyncTask {
                        print("hello world")
                    }
                }
        }
    }
    
    func performAsyncTask(completion: () -> Void) {
        Thread.sleep(forTimeInterval: 10.0)
        completion() // Calling the completion closure after the task is finished
    }
}
