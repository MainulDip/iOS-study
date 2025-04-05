### Combine Setup Initial:
Note: all `.sink` callers needs to be stored, either separately or using set of AnyCancellable `[AnyCancellable]`. Otherwise observation will not work
```swift
import UIKit
import Combine

class ViewController: UIViewController {
    
    // private var observer: AnyCancellable?
    private var observers: [AnyCancellable] = []
    private var viewModel: [String] = []

    let action = PassthroughSubject<String, Never>() // 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didFetchData()
    }
    
    // call ApiCaller using the singleton and update ui using combine
    private func didFetchData() {
        // observer
        APICaller.shared.fetchCompanies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                    case .failure(let error):
                    print("failed with error: \(error)")
                }
            }, receiveValue: { [weak self] value in
                self?.viewModel = value
                self?.tableView.reloadData()
            }).store(in: &observers)
    }


    // changing a tableViewCell's button title from tapping the same button
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellReusableIdentifire, for: indexPath) as! CustomCell

        cell.label.text = viewModel[indexPath.row]
        cell.action.sink { string in
            cell.button.setTitle(string, for: .normal)
            print(string)
        }.store(in: &observers) // all sink's return's need to be stored, otherwise it will not be get called
        return cell
    }


    // a button press handler to update info to the receiver
    @objc private func handleButtonTapped() {
        action.send("Button Tapped") // 4
    }
}

// APICaller.swift File -------------------------


import Foundation
import Combine

class APICaller {
    static let shared = APICaller() // singleton
    // access everything on this class using this instance
    
    private init(){} // blocking instantiation of this class
    
    func fetchCompanies() -> Future<[String], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let companies = ["A", "B"]
                promise(Result.success(companies))
            }
        }
    }
    
    // without combine, a completion handler is used, the completion handler is a closure here
    func fetchDataWithCompletionHandler(completion: ([String]) -> Void) {
        // do network call and supply the result into the closure's parameter
        // so that the ui can be updated
        let data = ["Data1", "Data2", "Data3"]
        completion(data)
    }
}
```