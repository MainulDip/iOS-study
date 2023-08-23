### TableViewController and Controller Binding:
* to use a controller for a TableViewController on the storyboard, the controller class have to extend the "UITableViewController" class.
* to bind, change/add TableViewController's class property (inside identity inspector) on storyboard with the custom controller class name. (Then the xcode assistant should work as is)
* and the cell inside TableView needs an Identifier (Reuse Identifier)

### TableView Without Nib:
```swift
import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Item 1", "Item 2", "Item 3" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // these are optional as this class extends UITableViewController
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusable-identifier-of-the-cell", for: indexPath)
        
        // every cell has textLabel property
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
}
```

### TableView cell's props:
- accessory : define checkmark, disclosure indicator, etc. Can be alter using : tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark/.none