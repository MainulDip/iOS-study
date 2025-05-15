//
//  View.swift
//  VIPER-intro-101
//
//  Created by Mainul Dip on 5/13/25.
//

import Foundation
import UIKit

// ViewController
// Protocol
// reference presenter as property

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    func update(with users: [User])
    func update(with error: String)
}


class UserViewController: UIViewController, AnyView {
    // Viper's AnyView Implementation Starts
    
    var presenter: (any AnyPresenter)?
    
    func update(with users: [User]) {
        print("update user")
        DispatchQueue.main.async { [weak self] in
            self?.users = users
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        print("console the error \(error)")
    }
    // Viper's AnyView Implementation Ends
    
    var users: [User] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    
}
