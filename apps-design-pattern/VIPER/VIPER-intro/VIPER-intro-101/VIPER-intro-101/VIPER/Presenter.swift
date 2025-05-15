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
    
    var interactor: (any AnyInteractor)? {
        didSet {
            interactor?.getUser()
        }
    }
    
    var view: (any AnyView)?
    
    func interactorDidFetchUsers(with result: Result<[User], any Error>) {
        print("From UserPresenter:interactorDidFetchUsers Data finished fetching")
        
        switch result {
            
        case .success(let data):
            view?.update(with: data)
        case .failure(let error):
            print("From UserPresenter:interactorDidFetchUsers \(error)")
            view?.update(with: "Something went wrong : From UserPresenter:interactorDidFetchUsers")
        }
    }
}

enum FetchError: Error {
    case NetworkRequestFailed(String)
    case DecodingFailed(String)
}
