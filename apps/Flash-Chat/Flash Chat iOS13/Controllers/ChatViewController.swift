//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    // get the firestore database
    let db = Firestore.firestore()
    
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
        
        // get messages form firestore
//        DispatchQueue.main.async {
            self.getFireStoreData()
//        }
//        getFireStoreData()
        
        
        
        // delegate UITableViewDataSource
        tableView.dataSource = self
        
        // register the table cell nib/xib's controller class
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        // delegate
        tableView.delegate = self
        
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        // implement firestore
        if let messageBody = messageTextfield.text,
           let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]) { error in
                if let e = error {
                    print("FireStore Error: ", e)
                } else {
                    print("Firestore Database Updated Successfully")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
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
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lighBlue)
            cell.label.textColor = UIColor(named: K.BrandColors.blue)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        
        return cell
    }
}


extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row's index is : \(indexPath.row)")
    }
}

// MARK : FireStore Getting Data
extension ChatViewController {
    func getFireStoreData() {
        
        // clear messages
        self.messages = []
        
        let docRef = db.collection(K.FStore.collectionName)

        docRef.order(by: K.FStore.dateField).addSnapshotListener { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data()[K.FStore.senderField]!)")
                    let sender: String = document.data()[K.FStore.senderField]! as! String
                    let body: String = document.data()[K.FStore.bodyField]! as! String
                    let newMsg = Message(sender: sender, body: body)
                    self.messages.append(newMsg)
                    print(messages.count)
                    
                    // update the table view, also DispatchQueue to be extra safe side to confirm the background thread is synced into main thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                        // scroll to the last message thats been newly sent
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
            }
        }
    }
}
