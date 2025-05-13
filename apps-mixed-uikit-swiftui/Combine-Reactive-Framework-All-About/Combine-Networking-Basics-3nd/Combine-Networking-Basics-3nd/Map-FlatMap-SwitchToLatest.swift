//
//  Map-FlatMap-SwitchToLatest.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 5/11/25.
//

import Foundation
import Combine

var cancelable: [AnyCancellable] = []

func singleDimentionalPublisher() {
    [1,2,3]
        .publisher
        .map { $0 * $0 }
        .sink { print($0) }
        .store(in: &cancelable)
}

// MARK: Multi Diemsional Publisher, aka, Publisher of Publisher
struct User {
    let name: CurrentValueSubject<String, Never>
}

func publisherOfPublisher() {
    let passThroughUserSubject = PassthroughSubject<User, Never>()
    /*
    => if we ignore the upstream as .map's output and pass a Just publisher, like
    : passThroughUserSubject.map { _ in Just(1) }
    => the return type
    :   Publisher.Map<PassthroughSubject<User, Never>, Just<Int>>
    => where the upstream type was
    :    PassthroughSubject<User, Never>
    */
    
    let m = passThroughUserSubject
        // .map { $0.name } // changing the upstream publisher into a publisher of User's property
        .map { $0 } // changing the upstream publisher into a full User type
    // let s = m.sink { print(" User.name: \($0.value)") } // if the publisher is a User's property (name), we can print using $0.value
    // here m: Publishers.Map<PassthroughSubject<User, Never>, User>
    let s = m.sink { print(" User.name: \($0.name.value)") } // if the publisher is a whole User type, we have to drill down to get the actual value.
    s.store(in: &cancelable)
    
    let user = User(name: .init("Mainul"))
    passThroughUserSubject.send(user)
    // prints `User.name: Mainul`
}


func publisherOfPublisherWithFlatMap() {
    let passThroughUserSubject = PassthroughSubject<User, Never>()

    let fm = passThroughUserSubject
        .flatMap { $0.name } // Publishers.FlatMap<CurrentValueSubject<String, Never>, PassthroughSubject<User, Never>>
        .eraseToAnyPublisher() // AnyPublisher<String, Never>
        .print("", to: nil)
        // .switchToLatest() // will not compile
        // flatMap will flatten down the multi dimensional publisher into a single dimensional publisher
        // and will only emit raw value, which is not a publisher property anymore (contrary to map)
        // and .switchToLatest() expect a property which is a publisher itself, not raw value
        
    let s = fm.sink { print(" User.name: \($0)") }
    s.store(in: &cancelable)
    
    let user = User(name: .init("Mainul"))
    passThroughUserSubject.send(user)
    // prints `User.name: Mainul`
}
