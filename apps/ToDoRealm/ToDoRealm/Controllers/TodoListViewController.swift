//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{
    
    var realm = try! Realm()
    
    var todoItems: Results<Item>?
    var selectedCategory: Category? {
        didSet {
            loadData()
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // MARK: - TableView Cell Bindings
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        
        let theItem = todoItems?[indexPath.row]
        cell.textLabel?.text = theItem?.title ?? "No Item Yet"
        if let item = theItem {
            cell.accessoryType = item.done ? .checkmark : .none
        }
        
        return cell
    }
    
    // MARK: - TableView Delegates Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The selected row is \(indexPath.row)")
        
        // seleced row flash effect
        tableView.deselectRow(at: indexPath, animated: true)
        
        // toggle the object prop
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                    
                    // deleting
//                    realm.delete(item)
                }
            } catch {
                print ("error updating", error)
            }
            
        }
        
//        saveItem()
        tableView.reloadData()
    }
    
    // MARK: - Add New Item
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        print("adding item")
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            print("Success")
            
            if let text = textField.text {
                DispatchQueue.main.async {
                    
                    if let currentCategory = self.selectedCategory {
                        do {
                            try self.realm.write {
                                let newItem = Item()
                                newItem.title = text
                                currentCategory.items.append(newItem)
                            }
                        } catch {
                            print(error)
                        }
                    }
                    
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
    
    // MARK: - Custom NSCoder Encoder and Decoder Function
    
    func saveItem(_ item: Item) {
        do {
            try realm.write({
                realm.add(item)
            })
        } catch {
            print("Saving Context Error: ", error)
        }
    }
    
    func loadData() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
//        print(todoItems?[0] ?? "no item")
    }
}

// MARK: - SearBar Fucntions
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            todoItems = todoItems?.filter("title CONTAINS[cd] %@", text).sorted(byKeyPath: "dateCreated", ascending: true)
        }
//        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()

            DispatchQueue.main.async {
                // hide the searchBar
                searchBar.resignFirstResponder()
            }
        }
    }
}

