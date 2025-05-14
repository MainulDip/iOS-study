//
//  Interactor.swift
//  VIPER-intro-101
//
//  Created by Mainul Dip on 5/13/25.
//

import Foundation

// object
// protocol
// reference to presenter
// fetch data, perform interaction and handover the data to the presenter
// api call to https://jsonplaceholder.typicode.com/todos/1

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUser()
}


class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUser() {
        print("Call Network Fetch User")
    }
    
    
}
