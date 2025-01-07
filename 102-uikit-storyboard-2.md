### TableViewController and Controller Binding:
* to use a controller for a TableViewController on the storyboard, the controller class have to extend the "UITableViewController" class.
* to bind, change/add TableViewController's class property (inside identity inspector) on storyboard with the custom controller class name. (Then the xcode assistant should work as is)
* and the cell inside TableView needs an Identifier (Reuse Identifier)


### iOS alert
```swift
let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
let action = UIAlertAction(title: "Add Item", style: .default) { action in
    print("Success")
    
    if let text = textField.text {
        DispatchQueue.main.async {
            self.itemArray.append(text)
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
```

### First Time Init to Check:
```swift
// on AppDelegate, initialize the Realm without let and assign to underscores inside do/catch block
_ = Try Realm()
```
### Task
=> SwipeCellKit (Delete feature for todo realm app)
=> In App Purchase | Not Now
=> Swift Deep Diving.......