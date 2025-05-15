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
// api call to https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUser()
}


class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUser() {
        print("Call Network Fetch User")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error  in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.NetworkRequestFailed("\(String(describing: error))")))
                return
            }
            
            do {
                let decodeDataResponse = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(decodeDataResponse))
                
            } catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.DecodingFailed("\(error)")))
            }
        }
        
        task.resume()
        
    }
    
    
}
