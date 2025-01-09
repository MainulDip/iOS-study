### Overviews:
Quick guide building view's programmatically instead of interface builder (storyboard, ib-outlet) on uikit.

### Setups:
Starting a new app using `storyboard` and start coding from the `ViewController` will work. 

Changing the background of the first screen
- inserting `view.backgroundColor = .yellow` after `super.viewDidLoad()` will change the background color. (`cmd + r`to build and launch )

But can be clean the project little more for exact use case

### intro into programmatic view:
- `view.backgroundColor = .yellow` after `super.viewDidLoad()` of `ViewController` will change the background color

- image 
```swift
let imageView = UIImageView(image: <img>)
view.addSubview(imageView)

// fixed positioning
imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

// auto layout : centering view
imageView.translatesAutoresizingMaskIntoConstraints = false // enables auto layout
imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
imageView.withAnchor.constraint(equalTo: 50).isActive = true
imageView.HeightAnchor.constraint(equalTo: 50).isActive = true

```
