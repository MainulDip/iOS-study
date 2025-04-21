//
//  Code.swift
//  Combine-Basics-2nd
//
//  Created by Mainul Dip on 4/17/25.
//

import Foundation
import Combine

// Combine/Reactive Way of doing things

var cancellables: Set<AnyCancellable> = []

func run() {
    Just(42)
        .delay(for: 2, scheduler: DispatchQueue.main)
        .sink { value in
            print(value)
        }
        .store(in: &cancellables)
    
    [1, 2, 3, 4, 5, 6, 7]
        .publisher
        .delay(for: 1, scheduler: DispatchQueue.main)
        .sink { value in
            print(value)
        }
        .store(in: &cancellables)
    
    [1, 2, 3, 4, 5, 6, 7]
        .publisher
        .filter { value -> Bool in value.isMultiple(of: 2) == false}
        .print()
        .map { $0 * $0 }
        .delay(for: 1, scheduler: DispatchQueue.main)
        .sink { value in
            print(value)
        }
        .store(in: &cancellables)
}


// Manual way of doing things without combine/reactive approach
func fetchUserId(_ completionHandler: @escaping(Result<Int, Error>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        let id = 47
        completionHandler(.success(id))
    }
}

func fetchName(for userId: Int, _ completionHandler: @escaping(Result<String, Error>) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        let res = "Data for user \(userId)"
        completionHandler(.success(res))
    }
}

func run2() {
    fetchUserId { idResult in
        switch idResult {
        case .success(let id):
            fetchName(for: id) { nameResult in
                switch nameResult {
                case .success(let name):
                    print(name)
                case .failure(let failure):
                    print("\(failure) in fetchName")
                }
            }
        case .failure(let failure):
            print("\(failure) in fetchUserId")
            // Dealing with failure will introduce more callback
        }
    }
}
