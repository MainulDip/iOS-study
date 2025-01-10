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

### Auto Layout Constraints:
auto layout needs at least two constraints for views having an intrinsic size (images, having width & height) and four for views without having an intrinsic size (text, size of text depends on various factors)