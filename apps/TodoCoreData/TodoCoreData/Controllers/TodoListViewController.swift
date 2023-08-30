//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    
//    var container: NSPersistentContainer!
    
    var itemArray: [Item] = []
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    // Persistance local sotrage using UserDefaults
    let defaults = UserDefaults.standard
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard container != nil else {
//            fatalError("This view needs a persistent container.")
//        }
        // The persistent container is available.
        
        print("Our DataFilePath", FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))
        print(dataFilePath ?? "dataFilePant is nil lol")
        
        // load data form CoreData Database
        loadData()
        
        
        // get local data and update the local list using generics
//        if let url = dataFilePath {
//            let sth: [Item] = decodeItemDataGenerics(filePath: url)
//            itemArray = sth
//        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // MARK: - TableView Cell Bindings
    
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
    
    // MARK: - TableView Delegates Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The selected row is \(indexPath.row)")
        
        // seleced row flash effect
        tableView.deselectRow(at: indexPath, animated: true)
        
        // toggle the object prop
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItem()
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
                    let newItem = Item(context: self.context)
                    newItem.title = text
                    newItem.done = false
                    self.itemArray.append(newItem)
                    
                    
                    self.saveItem()
                    
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
    
    func saveItem() {
        do {
            try context.save()
        } catch {
            print("Saving Context Error: ", error)
        }
    }
    
    func loadData() {
        var storedData: [Item] = []
        
        // let request = Item.fetchRequest() // can build the request object this way too
        do {
            storedData = try context.fetch(.init(entityName: "Item"))
        } catch {
            print("Data Fetching Error: ", error)
        }
        itemArray = storedData
    }
    
    
    
}

// MARK: - SearBar Fucntions
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // build the request
        let request = Item.fetchRequest()
        
        // NSPredicate, [cd] makes the search case and diacritic insensitive
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text ?? "")
        request.predicate = predicate
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Some Error: \(error)")
        }
        
        tableView.reloadData()
        print("Btn Pressed For: Search Text: ", itemArray)
    }
}

