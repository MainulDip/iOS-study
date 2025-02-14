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

