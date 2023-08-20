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