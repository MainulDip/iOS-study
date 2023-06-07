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