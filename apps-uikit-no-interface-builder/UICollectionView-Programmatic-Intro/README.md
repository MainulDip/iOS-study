### Basic UICollectionView Implementation:
```swift
class TwoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.cyan

        self.view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath)

        cell.backgroundColor = UIColor.green
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 50, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

}
```


### Printing the type:
Printing from a UICollectionViewController
```swift
print("\(String(describing: type(of: self)))")
print("\(String(describing: type(of: collectionView)))")
print("\(String(describing: type(of: view)))")
```

### UICollectionViewController | view vs collectionView:
This class already extends the `UIViewController` and confronts to the `UICollectionViewDelegate` and `UICollectionViewDataSource` protocols.

Behind the scene, `view` property form the UIViewController is the parent of the `collectionView` property of the UICollectionViewController. So changing background will be visible when done on `collectionView.backgroundColor`

### ...Layout vs ...FlowLayout:
The `UICollectionViewLayout` is for implementing custom collection view that requires some advanced functionality ie, both way of scrolling (X and Y axis). 

And `UICollectionViewFlow` layout provide some default structure already implemented. 

### Cells Dynamic Height Implementation:
From the controller auto sizing needs to be set. when done the cell's class `method` will be called
```swift
// form controller
(collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize

// from cell class
override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout() // only this will not work
        layoutIfNeeded() // only this will work though
        
        // use injected superview
        layoutAttributes.frame.size = CGSize(width: ultimateSuperViewWidth!, height: contentView.systemLayoutSizeFitting(cellLabel!.frame.size).height)
        
        return layoutAttributes
    }
```

### Sample UICollectionViewController with Flow Layout Implementation:
```swift
// part of the SceneDelegate.swift
guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let uiColFlowLayout = UICollectionViewFlowLayout()
        // static size can also be set form here
        // uiColFlowLayout.itemSize = CGSize(width: 100, height: 100)
        window?.rootViewController = CustomCollectionVC(collectionViewLayout: uiColFlowLayout)
        window?.makeKeyAndVisible()



// Custom UICollectionViewController implementation ----

import UIKit

class CustomCollectionVC: UICollectionViewController {
    
    // Cell Identifier
    struct CellIdentifier {
        static let customCell = "CustomCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .orange
//        print("hello3")
        
        // First thing for dynamic height and width , aka set auto sizing cell,
        // the logic for autosizing is in preferredLayoutAttributesFitting cells function
        (collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        // register the cell class
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: CellIdentifier.customCell)
        
        setupDelegation()
    }
    
    func setupDelegation() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataSource.names.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.customCell, for: indexPath) as! CustomCell
        
        // set dynamic label for the text view inside cell
        customCell.cellLabel?.text = DataSource.names[indexPath.item]
        customCell.ultimateSuperViewWidth = self.view.frame.width
        
        return customCell
    }
}

// MARK: delegation extension for setting static width and height (CGSize)
//extension CustomCollectionVC: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        view.layoutIfNeeded()
//        return CGSize(width: view.frame.width, height: view.systemLayoutSizeFitting(collectionViewLayout.collectionViewContentSize).height)
//    }
//}

// data extension
extension CustomCollectionVC {
    struct DataSource {
        static let names = ["First Name", "Second Name", "Third Name", "Set this constant as the value for the estimatedItemSize property to enable self-sizing cells for your collection view. This is a non-zero, placeholder value that tells the collection view to query each cell for its actual size using the cell’s preferredLayoutAttributesFitting(_:) method", "Fifth Name"]
    }
}


// Cell Class ---------------------------------

class CustomCell: UICollectionViewCell {
    
    var cellLabel: UILabel?
    var ultimateSuperViewWidth: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCell {
    func nameLabel(_ superView: UIView) -> UILabel {
        let label = UILabel()
        superView.addSubview(label)
        label.textAlignment = .center
        label.text = "Hello"
        label.numberOfLines = 0
        
        // setup aluto layout
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: superView.widthAnchor).isActive = true
        
        return label
    }
    
    func setupFrame() {
        contentView.backgroundColor = .yellow
        let cl = nameLabel(self.contentView)
        cellLabel = cl
        
        // print("\(String(describing: type(of: contentView)))")
    }
}


// Custom Cell Dynamic Height
extension CustomCell {
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout() // only this will not work
        layoutIfNeeded() // only this will work though
        
        // this will also work
        // layoutAttributes.frame.size = CGSize(width: contentView.superview?.superview?.frame.width ?? 0, height: cellLabel?.intrinsicContentSize.height ?? 0)
        
        // layoutAttributes.frame.size = CGSize(width: contentView.superview?.superview?.systemLayoutSizeFitting(cellLabel!.frame.size).width ?? 0, height: contentView.systemLayoutSizeFitting(cellLabel!.frame.size).height)
        
        // use injected superview
        layoutAttributes.frame.size = CGSize(width: ultimateSuperViewWidth!, height: contentView.systemLayoutSizeFitting(cellLabel!.frame.size).height)
        
        return layoutAttributes
    }
}
```

### `view.systemLayoutSizeFitting` vs `view.intrinsicContentSize`:


### `setNeedsLayout` vs `layoutIfNeeded` :