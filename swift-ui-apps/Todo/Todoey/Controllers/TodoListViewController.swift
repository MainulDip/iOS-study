//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray: [Item] = []
    
    // Persistance local sotrage using UserDefaults
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // load local data
        if let items = defaults.object(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
        let newItem = Item(title: "New Item 1")
//        newItem.done = true
        itemArray.append(newItem)
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
        itemArray.append(Item(title: "New Item 1"))
    
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // MARK - TableView Cell Bindings
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        
        let theItem = itemArray[indexPath.row]
        cell.textLabel?.text = theItem.title
        cell.accessoryType = theItem.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK - TableView Delegates Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The selected row is \(indexPath.row)")
        
        // seleced row flash effect
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
    }
    
    // MARK - Add New Item
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        print("adding item")
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            print("Success")
            
            if let text = textField.text {
                DispatchQueue.main.async {
                    let newItem = Item(title: text)
                    self.itemArray.append(newItem)
                    
                    // update to the persistance UserDefaults
                    self.defaults.set(self.itemArray, forKey: "TodoListArray")
                    
                    // reload the tableView
                    self.tableView.reloadData()
                }
            }
            
        }
        
        // set alert text field placeholder text and get the alertTextField data
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Item"
            
            // populate data to use other scope
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

