//
//  ViewController.swift
//  Combine-Intro-Uikit-First
//
//  Created by Mainul Dip on 4/2/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    // private var observer: AnyCancellable?
    private var observers: [AnyCancellable] = []
    private var viewModel: [String] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomCell.self, forCellReuseIdentifier: K.cellReusableIdentifire)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.backgroundColor = .orange
        
        setupTableViewLayout()
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
}


// MARK: - TableView's DataSource and Delegation
extension ViewController :  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Hi from numberOfRowsInSection")
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellReusableIdentifire, for: indexPath) as! CustomCell
        cell.label.text = viewModel[indexPath.row]
        cell.action.sink { string in
            cell.button.setTitle(string, for: .normal)
            print(string)
        }.store(in: &observers) // all sink's return's need to be stored, otherwise it will not be get called
        print("hi from cellForRowAt")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentHeight = tableView.rowHeight
        print("currentHeight \(currentHeight)")
        return  currentHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // proceed when a row is tapped
        print("The row \(indexPath.row) was selected")
    }
    
}


// MARK: - Setup TableView Layout
extension ViewController {
    private func setupTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

class CustomCell: UITableViewCell {
    
    let label = UILabel()
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("Button", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let action = PassthroughSubject<String, Never>()
    @objc private func handleButtonTapped() {
        action.send("Button Tapped")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .green
        
        contentView.addSubview(label)
        attatchLabelToLayout()
        contentView.addSubview(button)
        attatchButtonToLayout()
        
        print("hi")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attatchLabelToLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func attatchButtonToLayout() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: label.topAnchor, constant: 8).isActive = true
        button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8).isActive = true
        button.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: -8).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
    }
}


class K {
    static let cellReusableIdentifire = "cell"
}


/*
 Workflow: Use Combine to fetch data from an API and show them using UITableView
 */
