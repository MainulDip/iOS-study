### Overviews:
Quick guide building view's programmatically instead of interface builder (storyboard, ib-outlet) on uikit.

### Setups:
Starting a new app using `storyboard` and start coding from the `ViewController` will work. 

Changing the background of the first screen.
- inserting `view.backgroundColor = .yellow` after `super.viewDidLoad()` will change the background color. (`cmd + r`to build and launch )

But can be clean the project little more for exact use case

### intro into programmatic view:
- `view.backgroundColor = .yellow` after `super.viewDidLoad()` of `ViewController` will change the background color

- image 
```swift
override func viewDidLoad() {
        super.viewDidLoad()
        print("From Viewcontroller");
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        
        let imageView = UIImageView(image: .yummyFoodLogo)
        view.addSubview(imageView)
        
        // imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        // this 'll place the image at the top-left x:0 y:0 coordinate with 50x50 height
        
        // auto layout
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable auto layout
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true // place middle of the screen
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true // place 100 below the top anchor
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true        
    }
```

### Importing and using assets/images:
From `Assets.xcassets` Images can be imported or dragged into. Each entry can support multiple (usually 3) variants for different device resolution. When dragging multiple images together, images suffixed with `@1..3x` will be sorted automatically, like `imagename@1x.jpeg` (`name@Nx.ext`)

After importing into xcassets, images can be imported predictable way where parameter accepts `UIImage?`
```swift
// once image is imported/dragged into Assets.xcassets 
let imageView2 = UIImageView(image: UIImage(named: "yummy-food-logo"))
let imageView = UIImageView(image: .yummyFoodLogo) // predictable way
```

### Auto Layout Constraints and organized code:
auto layout needs at least two constraints for views having an intrinsic size (images, having width & height) and four for views without having an intrinsic size (text, size of text depends on various factors)

```swift
class ViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: .yummyFoodLogo)
        // auto layout enableing
        // adding border with round corner styling
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor(.red).cgColor
        imageView.layer.cornerRadius = 20
        // enable auto layout
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Hello World!"
        // enable auto layout for this textView
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .boldSystemFont(ofSize: 19)
        textView.textAlignment = .center
        textView.isEditable = false // stop allowing text editing
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("From Viewcontroller");
        // Do any additional setup after loading the view.
        view.addSubview(logoImageView)
        view.addSubview(descriptionTextView)
        setupLayout()
    }
    
    private func setupLayout() {
        // view.backgroundColor = .yellow // make the app screen yellow
        // imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50) // not for auto-layout
        // this 'll place the image at the top-left x:0 y:0 cordinate with 50x50 height
        
        // auto layout tuning for logoImageView
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true // will make it center of the screen
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // // auto layout tuning for descriptionTextView
        // 4 constran is necessay for non-intrinsic-size view, like text
        // the auto layout needs at least two constraints for views having an intrinsic size (image) and at least four for views with no intrinsic size (text>
        
        descriptionTextView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true        
    }
}
```

### Auto Layout Landscape Orientation 1st steep:
Usually a container view is placed underneath the child views, and will use the container anchor for child placement. 

tip: cmd + left/right arrow to rotate simulator

```swift
// start building container defining UIView().frame size before applying auto layout
let topImageContainerView = UIView()
topImageContainerView.backgroundColor = .blue
view.addSubview(topImageContainerView)
topImageContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
// for testing this 'll place the image at the top-left x:0 y:0 coordinate with 50x50 height
```


Applying auto layout to the container
Note: leading/trailing vs right/left anchor : some language are left to right (ltr), so apple recommends leading/trailing constraints.

```swift
        let topImageContainerView = UIView()
        topImageContainerView.backgroundColor = .blue
        view.addSubview(topImageContainerView)
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        // using leading/trailing instead of right/left
        // topImageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        // topImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        // setting height equal to half of the screen height
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
```


### Auto layout 2nd steep | child anchoring with the container's anchor:

### Get device orientation change event:
Orientation events
https://medium.com/codewords/orientation-responsive-ui-in-ios-beea7644b3c

https://www.waldo.com/blog/swift-selector#:~:text=Apple%20defines%20a%20selector%20as,using%20the%20%23selector%20expression.%22
```swift
func callFromViewDidLoad() {
    NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
}

@objc func orientationChanged() {
    print(UIDevice.current.orientation.rawValue)
}
```