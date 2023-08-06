//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey"),
        Message(sender: "11@2.com", body: "Hey"),
        Message(sender: "123@2.com", body: "Hey")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set page title
        title = "Flash Chat"
        // hide back button through navigationItem
        navigationItem.hidesBackButton = true
        
        // delegate UITableViewDataSource
        tableView.dataSource = self
        
        // delegate
        tableView.delegate = self
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func loggingOut(_ sender: UIBarButtonItem) {
        
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)

        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    
}

//MARK : Table View Integration
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(messages[indexPath.row].body)"
        return cell
    }
}


extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row's index is : \(indexPath.row)")
    }
}
