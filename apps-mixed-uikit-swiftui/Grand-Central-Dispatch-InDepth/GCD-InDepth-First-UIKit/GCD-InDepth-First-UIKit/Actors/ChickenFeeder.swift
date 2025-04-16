//
//  ChickenFeeder.swift
//  GCD-InDepth-First-UIKit
//
//  Created by Mainul Dip on 4/12/25.
//

import Foundation

@MainActor
actor ChickenFeeder {
    
    // static let shared: ChickenFeeder = ChickenFeeder() // singleton, guaranteed to be lazily initialized only once
     static var shared: ChickenFeeder? = ChickenFeeder()
    
    let food = "worms"
    private var numberOfEatingChickens: Int = 0
    
    private init() {
        print("ChickenFeeder had been initialized")
    }
    
    deinit {
        print("ChickenFeeder deinit")
    }
    
    func chickenStartsEating() async {
        do {
            try await Task.sleep(for: .seconds(1))
            numberOfEatingChickens += 1
            print("numberOfEatingChickens : \(numberOfEatingChickens)")
        } catch {
            print("error: \(error)")
        }
        
    }
    
    func chickenStopsEating() async {
        try? await Task.sleep(for: .seconds(1))
        numberOfEatingChickens -= 1
        print("numberOfEatingChickens: \(numberOfEatingChickens)")
    }
    
    // as all methods and mutalble props are isolated by default
    // accessing immutable constants doesn't require `await`
    // `nonisolated` ensures, this method can be called without `await`, hence there will be no suspension
    nonisolated func chickenFood() -> String {
        return self.food
    }
    
    func chickeFinishEatingAfterDelay() {
        Thread.sleep(forTimeInterval: 2)
        numberOfEatingChickens -= 1
        print("After 2 seconds chicken/s finished eating, is current thread main = \(Thread.isMainThread)")
    }
}
