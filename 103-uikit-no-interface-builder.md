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

Also `cmd + shift + l` (gui `view > show library`) import (drag/drop) image, UIComponents/View etc 
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
Used to control layout across landscape and portrait orientation. A container usually contain child views, and those child views are constraint to parent/container anchors.

Note: Container view (or any other view) needs to be added as `self.view`'s subView. No view should be left tangled situation.

```swift
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
        imageView.contentMode = .scaleAspectFit

    return imageView
}()

override func viewDidLoad() {
    super.viewDidLoad()
    // view.addSubview(logoImageView)
    setupLayout()
}

private func setupContainerLayout() {
    let topImageContainerView = UIView()
    topImageContainerView.backgroundColor = .blue
    view.addSubview(topImageContainerView)
    // topImageContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    // for testing this 'll place the image at the top-left x:0 y:0 cordinate with 50x50 height

    topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
    topImageContainerView.addSubview(logoImageView)

    topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true


    // auto layout tuning for logoImageView
    logoImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
    logoImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
    // logoImageView.topAnchor.constraint(equalTo: topImageContainerView.topAnchor, constant: 100).isActive = true
    logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
}


```

### UITextView's AttributedText for more control:
```swift
let descriptionTextView: UITextView = {
    let textView = UITextView()
    // enable auto layout for this textView
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    // textView.text = "Hello World!"
    // textView.font = .boldSystemFont(ofSize: 19)
    
    // using farther configuration using `UITextView().attributedText`
    let attributedText = NSMutableAttributedString(string: "Hello World", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.gray])
    
    attributedText.append(NSAttributedString(string: "\n\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
    
    textView.attributedText = attributedText
    
    textView.textAlignment = .center
    textView.isEditable = false // stop allowing text editing
    textView.isScrollEnabled = false
    return textView
}()
```
### Padding left/right using `constant:`:
```swift
descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 12).isActive = true // constant will behave like padding
descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true // constant will behave like left padding here
descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true // negative constant will behave like right padding here
descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
```
### UIStackView Padding/Margin without constraints:
```swift
stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
stackView.isLayoutMarginsRelativeArrangement = true
```

### UIButton, Alternate way of auto layout constraints activation and `SafeArea` with `view.safeAreaLayoutGuide.topAnchor`:
```swift
 let button = UIButton(type: .system)
button.setTitle("Prev", for: .normal)
button.translatesAutoresizingMaskIntoConstraints = false
// activating auto layout's constraint using NSLayoutConstraint.activate([])
NSLayoutConstraint.activate([
//previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
previousButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
previousButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
previousButton.heightAnchor.constraint(equalToConstant: 50)
])
```

### UIStackView:
```swift
let yellowView = UIView()
yellowView.backgroundColor = .yellow

let greenView = UIView()
greenView.backgroundColor = .green

let blueView = UIView()
blueView.backgroundColor = .blue

let bottomControlStackView = UIStackView(arrangedSubviews: [yellowView, greenView, blueView])
bottomControlStackView.distribution = .fillEqually
// bottomControlStackView.axis = .vertical

bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(bottomControlStackView)

// alternate way of activating auto layout contraints
NSLayoutConstraint.activate([
    //previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
    bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
    bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
])
```


### UIPageControlView:

```swift
private let pageControl: UIPageControl = {
    let pc = UIPageControl()
    pc.currentPage = 0
    pc.numberOfPages = 4
    pc.currentPageIndicatorTintColor = UIColor.mainPink
    pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 202/255, blue: 224/255, alpha: 1)
    return pc
}()
```

### Programmatic ViewController Creation:
`AppDelegate.swift` used prior to ios 12 to set entry window. With ios 13 it's the `SceneDelegate` to be used

inside SceneDelegate's `scene` function, set the entry ViewController

```swift
// adding custom viewController as main entry point
window = UIWindow(windowScene: scene as! UIWindowScene)
window?.makeKeyAndVisible()
let demoViewController = UIViewController()
demoViewController.view.backgroundColor = .red
window?.rootViewController = demoViewController
```

### `UICollectionViewController`:
We need at least 2 function to override

To initialize a UICollectionViewController 
```swift
// from scenedelegate.swift
let collectionViewLayout = UICollectionViewFlowLayout()
let swippingController = SwipingController(collectionViewLayout: collectionViewLayout)
window?.rootViewController = swippingController
```

### Change properties on orientation change:
There are `willTransition` and `viewWillTransition` controller methods, which will be called when device orientation changes. From there, the properties should be changed based on `landscape` or `portrait` mode and lastly `self.view.layoutIfNeeded()` needs to be called to repaint the layout. 
To programmatically create constraints, use `Layout Anchors NSLayoutAnchor` or `NSLayoutConstraint` class or `Visual Format Language`. 


```swift
class ViewController: UIViewController {
    var descriptionLeadingConstraint = NSLayoutConstraint()
    var descriptionTrailingConstraint = NSLayoutConstraint()
    // other code

    let descriptionTextView: UITextView = {
        let textView = UITextView()textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Hello World!"
        textView.font = .boldSystemFont(ofSize: 19)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isLandscape = self.view.frame.width > self.view.frame.height
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 12).isActive = true // constant will behave like padding
        
        descriptionLeadingConstraint = descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: !isLandscape ? 80 : 160)
        descriptionLeadingConstraint.isActive = true // constant will behave like left padding here
        descriptionTrailingConstraint = descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: !isLandscape ? -80 : -160)
        descriptionTrailingConstraint.isActive = true // negative constant will behave like right padding here
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        let isLandscape = size.width > size.height
        self.descriptionLeadingConstraint.constant = !isLandscape ? 80 : 160
        self.descriptionTrailingConstraint.constant = !isLandscape ? -80 : -160
        self.view.layoutIfNeeded()
    }
}
```

programmatic constraint creation https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ProgrammaticallyCreatingConstraints.html#//apple_ref/doc/uid/TP40010853-CH16-SW1

Different UI repainting functions, `layoutIfNeeded`, `setNeedDisplay`, `layoutSubViews`, `setNeedLayout`
https://stackoverflow.com/questions/42158203/ios-uiview-setneedlayout-setneeddisplay-layoutsubviews-and-layoutifneeded

### ViewModel implementation:
```swift
// ViewModel.swift file
import Foundation

class ViewModel {
    struct Model {
        var result: String = ""
    }
    
    var model: Model = Model()
    
    var modelDidChange: () -> Void
    
    init(modelDidChange: @escaping () -> Void) {
        self.modelDidChange = modelDidChange
    }
    
    func didSelectAdd() {
        //update the data
        modelDidChange()
    }
    
    func didSelectSubtract() {
        
    }
}

// ViewController.swift file
class ViewController: UIViewController {

    let viewModel = ViewModel(modelDidChange: {
        //Update your view model with new data
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        // other code
    }
}
```

### `self` inside closure prop | `private lazy var`:
When self is used inside of a closure prop, IDE will issue an warning, as while the class starting initializing, the `self` will not be ready at that point. So always use `private lazy var` to initialize this kind of property.

```swift
private lazy var nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("NEXT", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    // let pinkColor = UIColor(red: 255/255, green: 102/255, blue: 153/255, alpha: 1)
    button.setTitleColor(UIColor.mainPink, for: .normal)
    button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
}()
```


### Docs Reading:
From xcode, `cmd + shift + 0/zero` to open developer documents. And each section containing `Essentials` will provide a good walk through and introductory guide. ie, for auto layout guide `UIKit > Essential > About App Development with UIkit` will provide a good overview about the framework and inside there is a link for auto layout guide. 

`UIKit > Views and Controls > UIView` for good overviews about `Views` in general. Some important view related guide is also there, like `Auto Layout`, `View Programming Guide`


### CHCR (Content Hugging and Compression Resistance):
Auto Layout represents a view’s intrinsic content size using a pair of constraints for each dimension. The content hugging pulls the view inward so that it fits snugly around the content. The compression resistance pushes the view outward so that it does not clip the content.


```swift
view.setContentHuggingPriority(.required, for: .horizontal)
view.setContentCompressionResistancePriority(.required, for: .horizontal)
```

### Left/Right vs Leading/Trailing & Opt-out by `semanticContentAttribute`:
For supporting both left-to-right and right-to-left language, Apple suggest to always use Leading/Trailing instead of Left/Right when anchoring.

Some ui elements requires exact view (no flipping for ltr/rtl) like, buttons that are based on physical directions (up, down, left, and right) should always stay same. 

The view’s `semanticContentAttribute` property determines whether the view’s content should flip when switching between left-to-right and right-to-left languages.1

### Must reading:
`View Programming Guide` for ios > https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009503

`Auto Layout Guide` > https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853

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
### Get if device is in landscape:
To get info if the device is in landscape, the appropriate option is to use `self.view.bound.width > self.view.bound.height` as these are available when first load and will be changed whenever orientation triggered. The `view.frame.width/height` is populated lately after the transition has been done. So when working with `viewWillTransition`, the bound will be already in changed state, where frame will not.
```swift
 var isLandscape: Bool {
        self.view.bounds.width > self.view.bounds.height
    }

override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
    print("self.isLandscape = \(isLandscape)") // true when triggered landscape
    print("self.view.frame.width > self.view.frame.height = \(self.view.frame.width > self.view.frame.height)") // it's not yet changed, so will be false even-if the device orientation had been triggered
}
```
### CoreData and SwiftData: