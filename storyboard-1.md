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
### IB Outlet (Interface Builder Outlet) | linking view with the ViewContrllers:
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
}
```