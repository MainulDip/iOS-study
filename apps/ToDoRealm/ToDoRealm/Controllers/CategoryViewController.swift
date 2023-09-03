//
//  CategoryViewControllerTableViewController.swift
//  TodoCoreData
//
//  Created by Mainul Dip on 8/30/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoryArr: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("adding item")
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            print("Success")
            
            if let text = textField.text {
                DispatchQueue.main.async {
                    let newItem = Category()
                    newItem.name = text
                    
                    
                    self.save(category: newItem)
                    
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
    
    func save(category: Category) {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Saving Context Error: ", error)
        }
    }
    
    func loadData() {
        categoryArr = realm.objects(Category.self)
    }
    
    // MARK: - TableView DataSource and Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArr?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let theItem = categoryArr![indexPath.row]
        cell.textLabel?.text = theItem.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row Text is : ", categoryArr![indexPath.row].name)
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArr![indexPath.row]
        }
//        destinationVC.itemArray = []
    }
    
    
    // MARK: - Data Manipulation Methos
    
    
}
