//
//  Router.swift
//  VIPER-intro-101
//
//  Created by Mainul Dip on 5/13/25.
//

import Foundation
import UIKit

// if there are different modules in an application, the router is used for routing within its own modules
// modules example: if an app has five tabs, each tabs can be considered as a module

// Router is the Entrypoint
// Define entrance ViewController and SceneDelegate
// Router is an Object


protocol AnyRouter {
    // var view: AnyView & UIViewController { get }
    typealias EntryPoint = AnyView & UIViewController
    var entryPoint: EntryPoint? { get }
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    
    var entryPoint: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        // instantiate View, Interactor and Presenter here and
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        presenter.router = router
        
        router.entryPoint = view as? EntryPoint
        
        return router
    }
}
