//
//  Presenter.swift
//  VIPER-intro-101
//
//  Created by Mainul Dip on 5/13/25.
//

import Foundation

// presenter glues View and Interactor togather
// its an Object
// conform to custom Protocol
// has reference to interactor, router and view
// presenter will give instruction to the View when the interactor completes its job


protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}


class UserPresenter: AnyPresenter {
    var router: (any AnyRouter)?
    
    var interactor: (any AnyInteractor)?
    
    var view: (any AnyView)?
    
    func interactorDidFetchUsers(with result: Result<[User], any Error>) {
        print("Data finished fetching")
    }
    
    
}
