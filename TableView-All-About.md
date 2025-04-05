### TableView Theory:
A UITableView is a subclass of UIScrollView which is a view that users can scroll through. UITableView is used to show a list of data. Each item inside of this list is represented by a view called a `UITableViewCell`. Each cell tends to look very similar to one another but are holding different data.

A UITableView can also contains sections where each section contains rows, and each row being represented by a cell

### TableView Implementation:
Can be implemented into a `ViewController` or Using Separate class inheriting from `UITableViewController` 

(UITableViewController Comes with Delegate and Datasource all ready inherited)


1. On a ViewController's `viewDidLoad`, add a tableView as the primary view's subView. 

2. and set `self` for tableView's dataSource and delegate. And properly constrain the tableView (otherwise nothing will be called related to `cell`)

3. The xcode will prompt for all the necessary boilerplate code, ie, conforming to the `UITableViewDataSource` and `UITableViewDelegate` 

4. also 2 required functions `tableView(_:_, numberOfRowsInSection section: Int)->Int` (for the row's total length) and `tableView(_:_,cellForRowAt indexPath: IndexPath)->UITableViewCell` for building and registering the `Cell` using the supplied tableView props `dequeueReusableCell`

5. the custom cell class needs to override the `override init(style:, reuseIdentifier:)` function where cell layout will be initiated. 


```swift
class ViewController: UIViewController {
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomCell.self, forCellReuseIdentifier: K.cellReusableIdentifire)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        // must properly constrain the tableView with the parent view, otherwise the `tableView(:cellForRowAt:)` and `Custom Cell` class will not be called

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }
}

extension ViewController :  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellReusableIdentifire, for: indexPath)
        return cell
    }   
}

class CustomCell: UITableViewCell {
    
    var label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .green
        
        contentView.addSubview(label)
        // set autolayout of the label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        print("hi")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```


### TableViewController and Controller Binding (StoryBoard):
* to use a controller for a TableViewController on the storyboard, the controller class have to extend the "UITableViewController" class.
* to bind, change/add TableViewController's class property (inside identity inspector) on storyboard with the custom controller class name. (Then the xcode assistant should work as is).......
* and the cell inside TableView needs an Identifier (Reuse Identifier).......

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


### UICollectionView Theory:
Similar to a UITableView, a UICollectionView is a sub-class of UIScrollView. In other words, it is also a scrollable view. However, a collection view is more dynamic and customizable than a table view. 

A collection view still contains sections, but instead of `rows` in a tableView, it uses `items`. Section can have their own `header`, `footer` and items list. Each item is represented by a UICollectionViewCell and can be displayed in a grid-like manner. Additionally, a UICollectionView also supports horizontal scrolling.

A UICollectionView will require a layout that confronts to the `UICollectionViewLayout`. A pre-build grid like layout comes with `UICollectionViewFlowLayout`, which is a subclass of the `UICollectionViewLayout`. For more flexibility, the base class should be subclassed.

Unlike tableView's Delegate function `tableView(_ tableView:,heightForRowAt:)` to set the individual row height (Global is set by `tableView.height`), the collectionView has this same kind of function available with the `UICollectionViewDelegateFlowLayout`  conformation, to set the individual collectionView item height.

### Implementation of a UICollectionView:
```swift
class ViewController: UIViewController {
    // 1. Create the property but don't initialize immediately
    // Note that this is different from a table view
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup here

	setupCollectionView() // 2. Configure the view
    }
		
    // 2. Configure the view
    private func setupCollectionView() {
	// 8. Create a FlowLayout
	let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = // .vertical or .horizontal
        layout.minimumLineSpacing = // (optional) spacing amount
        layout.minimumInteritemSpacing = // (optional) spacing amount

	// Initialize CollectionView with the layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)				
	collectionView.register(CustomTableViewCell.self, forCellWithReuseIdentifier: CustomTableViewCell.reuse) // 5
	collectionView.delegate = self // 6
	collectionView.dataSource = self // 7
		
	view.addSubview(collectionView) // 3
	collectionView.translatesAutoresizingMaskIntoConstraints = false // 4
		
	// 4. Set constraints
    }
}

// 6. Conform to `UICollectionViewDelegate`
extension ViewController: UICollectionViewDelegate {
    // `didSelectItemAt` (optional)
    // Additional functions here
}

// 7. Conform to `UICollectionViewDataSource`
extension ViewController: UICollectionViewDataSource {
    // `cellForItemAt`
    // `numberOfItemInSection`
    // Additional functions here
}

// 8. Conform to `UICollectionViewDelegateFlowLayout`
extension ViewController: UICollectionViewDelegateFlowLayout {
    // `sizeForItemAt`
    // Additional functions here
}
```