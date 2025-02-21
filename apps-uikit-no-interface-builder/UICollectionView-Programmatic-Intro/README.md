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
The `intrinsic` content size is a property that some interface objects implement (such as UILabel and UIButton) so that you do not have give them height and width constraints. For UIView alone, there is no `intrinsic` content size.

`view.systemLayoutSizeFitting` Returns the optimal size of the view based on its current constraints. It's different that intrinsic size and returns the actual size of the view

```swift
setNeedsLayout() // only this will not work
layoutIfNeeded() // only this will work though

// use injected superview
attribute.size = CGSize(width: ultimateSuperViewWidth! - 1, height: contentView.systemLayoutSizeFitting(cellLabel!.frame.size).height) // -1 is a bug
```


### `setNeedsLayout` vs `layoutIfNeeded`:
- `layoutIfNeeded` is a synchronous call that will let- the system update the views and force the layout engine to redraw the views.
- `setNeedsLayout` is a deferred call and asynchronous- call that will mark the layout has changed but it will call `layoutSubViews()` in the next cycle.
- Both `layoutIfNeeded` and `setNeedsLayout` call `layoutSubViews()`
- Better to have `setNeedsLayout` before calling `layoutIfNeeded` for the safer side. But it is not required in all cases. Because `layoutIfNeeded`- requires a signal to update.
- For animations, using `layoutIfNeeded` is a better option than calling setNeedsLayout. It ensures any pending layout updates are applied before the animation, resulting in smoother performance.
- The same logic applies to the `setNeedsUpdateConstraints` and `updateConstraintsIfNeeded`.

### bound vs frame of the view's:
At its simplest, a view’s `bounds` refers to its coordinates relative to its own space (as if the rest of your view hierarchy didn’t exist), whereas its `frame` refers to its coordinates relative to its parent’s space.


   - If you create a view at X:0, Y:0, width:100, height:100, its frame and bounds are the same.

   - If you move that view to X:100, its frame will reflect that change but its bounds will not. Remember, the bounds is relative to the view’s own space, and internally to the view nothing has changed.

   - If you transform the view, e.g. rotating it or scaling it up, the frame will change to reflect that, but the bounds still won’t – as far as the view is concerned internally, it hasn’t changed.
