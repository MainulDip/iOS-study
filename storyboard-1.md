## Overview:

### Structure:
- LaunchScreen.storyboard : Launch Screen of the app, only associated with intro animation/screen
- Main.storyboard : App's first screen/view
- ViewController.swift : Interface Builder
- SceneDelegate.swift :
- AppDelegate.swift :
- info.plist
- Assets.xcassets (Directory) :
    - 

### Assets and Icons Generator:
https://www.appicon.co is a good place to generate all the Image Sets and icons for both ios and Android.

* To actually add the assets to xcode, it requires to drag the files separately/exclusively into the Assets.xcassets folder within xcode. Otherwise the assets will not be visible inside xcode.
### IB Outlet (Interface Builder Outlet) | IBAction | linking view with the ViewContrllers:
From main.storyboard open the Assistance (it will bring the ViewContrller and main.swift file side by sede to do drag and drop operation)
Then drag the targeted view to the controller while pressing 'ctrl', give it a name and insert. Then it will insert the IB outlet.
```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var diceImageView1: UIImageView! // weak var doesn't stop ARC from disposing of the referenced instance.
    override func viewDidLoad() { // lifecycle method
        super.viewDidLoad()
        diceImageView1.image = #imageLiteral(resourceName: "DiceSix") // imageLiteral is a cool way in xcode to reference image by mouse click
        diceImageView1.alpha = 0.4
    }

    @IBAction func rollButtonPressed(_ sender: Any) {
        diceImageView2.image =  UIImage(imageLiteralResourceName: "DiceThree")
    }
}
```

### imageLiteral is Deprecated:
it's a drag and drop interface to put images directly into variables. Instade use 
```swift
diceImageView1.image =  UIImage(imageLiteralResourceName: "DiceSix")
```

### Naming Convention:
- camelCase : variables/properties, attributes, methods/functions
- kebab-case : Html, Css, Urls
- snake_case : for scripting languages (python, js)
- PascalCase : Classes, Interfaces, Structs, Namespaces

### np x++ or x-- or ++x or --x:

### generating random numbers:
Either use random number generator "Int.random(in: 0...uperLimit)" or use array.randomElement()
```swift
import UIKit

class ViewController: UIViewController { 

    var images: [String] = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"]; // swift array/collection
    var leftDiceNumber: Int? // swift optional/nullable
    var rightDiceNumber: Int? // optional/nullable

    @IBAction func somefunction(_ sender: Any) { 
        leftDiceNumber = Int.random(in: 0..<images.count)
        rightDiceNumber = Int.random(in: 0..<self.images.count) // self is optional/implicit but can be explicit

        print("Dices images count: \(images.count)")

        diceImageView1.image =  UIImage(imageLiteralResourceName: images[leftDiceNumber!])

        // diceImageView2.image =  UIImage(imageLiteralResourceName: images[rightDiceNumber!])

        diceImageView2.image =  UIImage(imageLiteralResourceName: images.randomElement()!) // array.randomElement() is used instade of reandom number generator
    }
}
```

### Auto layouts:
Constraints are used to provide device agnostic responsive layout option. Besides setting the superview option, sometimes the view itself needs to little tweaking inside it's size inspectors.
- Embeding one or multiple views easily using 
- UIView / View : Container for other views to constrain multiple views easily using editor -> embed in -> view/stack etc. There is a quick embed in option at the bottom right corner of the storyboard visual builder window.
- Stack View : Container View Horizontal and Vertical Stack View arrangements
- Give attention to constraint to super view or safe area

* See Calculator and Dicee App for examples.

### IBAction to multiple UI Views:
A single IBAction can be triggered by multiple UI Views/Elements.

### Playing Sound:
```swift
import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!
    
    func playSound(sn fileName: String?) {
        
        // nil check will bypass all the optional checking afterwards
        if (fileName == nil) {
            return
        }
        
        let url = Bundle.main.url(forResource: fileName, withExtension: "wav")

        player = try! AVAudioPlayer(contentsOf: url!)
//        player.play()
        
        print("Playing Sound Of \(fileName!)")
        
    }
    
    
    @IBAction func keyPressed(_ sender: UIButton) {
        let soundName: String? = sender.titleLabel?.text
        playSound(sn : soundName)
        print( soundName ?? "No title label has been set yet"); // providing default value if soundName is nil
    }
}
```

### @objc func :
### mutating || mutating func :
To be able to change a struct's property (within the struct) form a function, the function needs to be prefixed with the mutating keyword.
```swift
struct QuestionStore {

    var currentQuestion = 0

    // this function is changing the currentQuestion property's value, so it must prefixed with mutating keyword
    mutating func getNextQuestion() -> Int {
        currentQuestion += 1
        return currentQuestion
    }
}
```

Note: if a protocol prefixes a method with mutating keyword, inherited class's method does not need to be prefixed with it. Like "class ViewController: UIViewController{}" in ios
```swift
protocol baseProtocol {
    // if protocol states the mutating keyword, inherited method does not need to be prefixed with mutating
    mutating func getNextQuestion() -> Int
}

class QuestionStore : baseProtocol {

    var currentQuestion = 0

    // Inherited method inside class does not need the mutating keyword
    func getNextQuestion() -> Int {
        currentQuestion += 1
        return currentQuestion
    }
}

var qs = QuestionStore()
print(qs.getNextQuestion(), qs.getNextQuestion())

// prints => 1 2
```
### Float's N number of Digits after the Decimal point:
```swift
let floatNumber = 3.1416
let twoDecimalPoint: String = String(format: "%.2f", floatNumber)
print(twoDecimalPoint) // 3.14
``` 

### Class vs Struct:
- Class has the inheritance capability. Inherit another class.
- Struct can only inherit protocol, a struct cannot inherit any struct or class.
- If class properties are left empty (no value assigned), init method is required. Struct's properties can be empty. 
- Classes are reference based and Structs are value based. A copied version of a class object is always in a reference with the base class. Chaiging either's property will reflect another. Where structs can be copy and both will be hold their values separately.
- Structs need "mutating" keyword before a function if that function changes any struct/self properties. As Structs are Immutable.
- Class method/function does not need mutating keyword

### NSObject (Next Steps) and ios inheritances:
Base class for ios. All classes inherit from this class. Steeve Jobs started this when he was kicked off from the Apple. Its a generic class (which describe general things, not specific), at last inheritance ends up being more specific, Like UIButton is very specific class describing Button specific things rather than being general or agnostic.

EX: UIButton <= UIControl <= UIView <= UIResponder <= NSObject

### UIKit:
Everything that starts with UI (UIButton, UILable, etc) are coming from UIKit.

### CG | CoreGraphics:
- CGRect : Core Graphics Rectangle
### Navigation | Controller to Controller :
```swift
// initialize the controller and call self.present with the controller as one of its parameter.
```
### Creating View on the fly by code Without Storyboard/GUI:
```swift
import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating view programaticaly
        
        // view is the parent element of all other views that comes with UIViewController
        view.backgroundColor = .blue
        
        let lable = UILabel()
        lable.text = "Second View Controller lable"
        // because textColor: UIColor! { get set }, we can write only .white instade of full UIColor.white
        lable.textColor = .white
        lable.frame = CGRect(x: 0, y: 0, width: 100, height: 67)
        
        // add the newly created lable view inside the container parent view
        view.addSubview(lable)
    }
}
```
### Type as! Type || Down Casting:
### Optional Unwrapping, Optional Binding, Nil Coalescing Operations (??):

### Optional Struct and Optional Chaining:

### tasks:
- navigation using segway, cocoa touch and back navigation
- sending parameters to the navigated view controller using segway prepare
- convert to MVC
- Implement background color change of the second screen based on BMI result
- Give advice based-on BMI