### Asynchronous Tasks and Threading Overview:

### Update Data In TableView:
To update data inside tableView, there is a function to reload data
```swift
// update the table view, also DispatchQueue to be extra safe side to confirm the background thread is synced into main thread
DispatchQueue.main.async {
    self.tableView.reloadData()
}
```