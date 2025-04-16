//
//  ViewModel.swift
//  GCD-InDepth-First-UIKit
//
//  Created by Mainul Dip on 4/13/25.
//


import Foundation

class ViewModel {
    lazy var chickenFeeder: ChickenFeeder? = ChickenFeeder.shared

    init() async {
        let work = Task { [weak self] in
            guard let chickenFeeder = self?.chickenFeeder else { return }
            await chickenFeeder.chickenStartsEating()
//            try await Task.sleep(for: .seconds(1))
            
            await chickenFeeder.chickeFinishEatingAfterDelay()
            
            await chickenFeeder.chickenStopsEating()
            
        }
        
        // sleep(2)
        print("accessing nonisolated func from ChickenFeeder Actor \(chickenFeeder?.chickenFood() ?? "nil")")
         print("work.value:\(await work.value)")
        
        // await Task.yield()
        // ChickenFeeder.shared = nil // when the singleton in nullable
        // self.chickenFeeder = nil
        
    }
}

// TODO: Complete all these checklist
/*
 - DispatchQueue Concurrent and Serial (Custom) Queue
 - Sync and Async Queue
 - Qos
 - Dispatch Group
 - Simaphore, Barrier
 - DispatchIO
 - DispatchWorkItem and DispatchSource
 
 Next
 - Actor, Task and Async/Await checklists on the Notion
 - Combine & Observable (Tomorrow)
 - URLSession In Depth (Tomorrow)
 - TableView and CollectionView (Tuesday)
 - Swift Data, Core Data, Realm, Local Storage (Tuesday)
 - Networking Layer, Caching, Design Pattern (Wednesday)
 - SwiftUI in UIkit and other way (Thursday)
 */
