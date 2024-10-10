## Overview:
uikit quick guide.

### Structure:
- LaunchScreen.storyboard : Launch Screen of the app, only associated with intro animation/screen.
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

### imageLiteral is Deprecated
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
### Navigation Storyboard, Cocoa Touch, Segue and Storybiard Segye Identifier :
- To perform Navigation based on storyboard design, Cocoa Touch Template can be used to make the view controller for it. 
- The newly created viewcontroller class name needs to be supplied inside storyboard's targeted scene's identity inspectory's class properties name.
- Then to create a navigation direction a segue need to be created by holding ctrl and dragging a connection handle form Storyboard's view controller to view controller.
- After creating the segue connection, the segue connection itself needs an identifier which will be used to perform navigation suing self.performSegue form a ViewController class (btn action event usually).
- Sending Data form controller to controller : "override func prepare(for segue: UIStoryboardSegue, sender: Any?){}" is used. and segue.destination is used to get the destination controller object itself.
- Back Navigaiton: 
```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destinationViewController: DestinationViewController = segue.destination as! DestinationViewController
        // Pass the selected object to the new view controller.
        resultViewController.bmiObj = self.bmi // sending a object as the destination controller's class property.
    }
``` 
### DownCasting | Forced DownCasting | Type as! Type :
If a class is inheriting form a superClass, we can treat the class as the superClass elsewhere in our application by DownCasing
```swift
// like segue context
// ex : class CustomViewController : UIViewController {...}
let customViewController = method.thatReturnUIViewController as! CustomViewController // forced DownCasting as the custom class
// send values as class parameter or something else
cutomViewController.props = newValue
``` 
### Optional Unwrapping, Optional Binding, Nil Coalescing Operations (??):
- Optional Unwrapping: optional!
- Optional Binding : if let safeOptional = optional { do something with safeOptional if it is really not nil }
- Nil Coalescing Operator : return optional ?? "some other value if optional is nil"

### Optional Struct and Optional Chaining:
Anything can be optional. Structs are treated as a Type, it can be optional too.
```swift
struct SomeStruct {...}
let struct: SomeStruct?
print("\(struct?.prop ?? "default value")")
```
### Light/Dark Mode || Appearance :
Apple only provide system color with dark/light mode variant. For custo color, "color set" of the xcassets is used for dark/light variant.
- color: From xcassets, add the color "color set" option to set the light mode and dark mode color, use the appearance attribute to "any light and dark" to get the option for dark mode variant.
- image: form xcassets add the "image set", set the appearances to "any light and dark" then set light/dark mode images. For vector image, set scales to single as vector image don't need other higher res variant

### task
- set the search field: 
    - set IBOutlet and IBAction for search btn (get and print the search input text)
    - set the keyboard (soft) enter button bind with the text field search button
    - UITextFieldDelegate: Implement from the viewController and add textFieldCustom.delegate = self (the view controller will be notified on text field event)
    - textFielShouldReturn : this will bind the soft keyboard's return/go btn with the text field's search
    - textFieldCustom.endEditing(true) : this will dismiss the soft keyboard upon the search button pressed
    - textFieldDidEndEditing : its a delegated method, it will triggered when the soft keyboard's enter btn is pressed. can be used to clear the search's text
    - textFieldShouldEndEditing : will trigger if user touche else where, or during the typing. can be used to validate the input text. true will dismiss the kyboard and the textFieldDidEndEditing method will be called

    - touchesBegan : to track if user touched/clicked somewhere else other than the soft keyboard or desired places.
    - 

### Lifecycle method's naming and functions:
...ShouldEnd... 's return true will trigger ...DidEnd... function

### Delegates (Protocol) :
It's the interface in other programming language. Both class and struct can implement form Protocol/s. Structs can only implement form Protocol/s not form another struct. But properties/methods can return anything (class or structure)
- for class, superclass comes first, the protocol/s => class myClass: SuperClass1, SuperClass2, Protocol1, Protocol2 {}
- protocol method cannot have bodies 
### Delegate Design Pattern

### Clima App:

### Flash-Chat App:
A chatting app, it's inside the apps dir
### Table View (android's LitView):
It is a vertical scrolling component, it stacks elements one after another vertically (ie: chatting interface) 

### Animation | Basing Using For Loop:
```swift
@IBOutlet weak var titleLabel: UILabel!
    
override func viewDidLoad() {
    super.viewDidLoad()

    titleLabel.text = ""
    
    var count = 0.0
    let textToAnimate = "⚡️FlashChat"
    
    for letter in textToAnimate {
        
        Timer.scheduledTimer(withTimeInterval: 0.1 * count, repeats: false) {_ in
            self.titleLabel.text?.append(letter)
        }

        count += 1   
    }
}
```

### CocoaPod | 3rd Party Library | Installing, Updating and Removing Pods:
CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects.
CocoaPods is built with Ruby and is installable with the default Ruby available on macOS.
Docs : https://cocoapods.org/

* Install :
- sudo gem install cocoapods
- pod setup --verbose
* Setting Up and Intalling 3rd party project
- navigate to the app's directory (same lavel as .xcodeproj) and run "pod init" to initialize the "Podfile"
- Setup the newly generated "Podfile" (a ruby file), customize the platform version, and other things
- inside the "target '' do" (ruby function) append the 3rd party library to add, ex: pod 'CLTypingLabel'
- then run "pod install"
- after the install, close any running xcode project, and open current project into xcode using newly generated ...xcworkspace file (as of cocoapod instruction)
* Updating Packages/Library:
- updating a specific pod: add version number after the pod name inside the Podfile, ex: pod 'podname', '~> 0.4.0'  then close xcode and run 'pod install' again. 
- updating all pods: also, running "pod update" will also update all the pods
* Uninstalling / Removing Pods :
- remove the pod name form the "Podfile" -> Close xcode and run "pod install", that will update the current state of the Podfile (remove the pod in this case)
### CocaPod Alternatives:
- Carthage:
- Swift Package Manager: Does not integrate with cocapod at the same time. (Note: if the package contain ...podspec file, it has support cocapod, if Pakage.swift is there, it support "swift package manager")
### Adding Package Using Swift Package Manager:
It a package is eligible for swift package manager, the root directory of the package must have "Package.swift" file. If so, then we can add the package through xcode -> file -> add packages -> paste the github package url (top right corner of the box)
### Firebase Integration:
- add the firebase "GoogleService-Info.plist" file to the root of the project
- add the cocapod entries for specific firebase api's 
   -  pod 'FirebaseAuth'
    - pod 'FirebaseFirestore'
- pod install
### Adding New User To firebase store:
- First enable the authentication user by email and password form firebase console.
- Then Follow instruction of the firebase docs
```swift
 if let email = emailTextfield.text, let password = passwordTextfield.text {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let e = error {
            print(e)
        }
        
        if let res = authResult {
            print("Printing auth resust --------")
            self.performSegue(withIdentifier: "RegisterToChat", sender: self)
            print(res)
        }
        print("registerPressed Called")
    }
}
```
### Login | Logout and Other :
See Flash Chat repo

### Constants from Global Use:
- Developers Use "K" as Constants (practice), and store all the constants inside the struct as typed property (static)
- Then assess the property using K.property name. 
```swift
struct K {
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
```

### Instance vs Type Property:
Struct, Class, Emum can have instance property and type (static property) also methods.
Type property does not require an Instance (Like other programming languages, Java, Kotlin)
Docs: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/
```swift
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
```

### Table View (Scrollable listView):
- table view : its the ListView/Recycler View in Android. It contains all the lists/cells as "table view cells"
    - attribute :  separator : separator for each line
- table view cells || prototype cell/view : blueprint of the list element
    * important attribute:
    - identifier : String to identify the cell blueprint form code
- table view controller : it's little limited compared to the "table view", so stick with that
### TableView DataSource vs Delegate:
- DataSource : forward data to the controller. It populate the tableView
- Delegate : 
### Table Cell Init:
- create a CocaTouch file with subclass of UITableViewCell (with xib checked) inside views directory to implement the fine-grain control over cell
- xcode will create 2 files, 1 swift and 1 XIB
- Note: XIB is a design file (formally known as NIB). It's like a storyboard file and the controller of this XIB file is the newly created swift file.
- provide an identifier for the top level container of the xib file
- after designing the xib file, connect IBOutlets and other things with the assistance.
- then the xib design file needs to be registered in the tableView Controller file. we need the "identifier" the parent/top container (Table View Cell) inside the xib and the name of the xib file (without xib extension)
```swift
// inside viewDidLoad
tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
```

### Table cell customization:
- label/text multiline : set line number to 0 to get dynamic multiline.
- border radius : from the xib's controller, change the xib's view elements property through IBOutlet.
```swift
// it's kina same like viewDidLoad in UIController
// this function gets called when the nib/xib loads
override func awakeFromNib() {
    super.awakeFromNib()
    
    messageBubble.layer.cornerRadius = messageBubble.frame.height / 4
}
```

### is || as || as? || as! (type check & casting):
- is : check to see if the object is a certain type. like: if sth of Type {}
- as : used to upcast into the superclass. Used less frequently in practice compared to downcast
- as! : used to forced downcast into subclass. throws error if the class doesn't match. You've to 100% certain about the casting class
- as? : used to optional downcast into subclass, can be used with "if let" binding

### Any || AnyObject || NSObject:
- Any : Anything Class of Struct
- AnyObject : Anything that is a object of any class (not struct)
- NSObject : Anything thst is a object of Apple's Foundation Library
```swift
let mixedList: [Any] = ["Sth", 7, 7.4] // String, Int & Float on same list by casting to Any
let classObje: [AnyObject] = [objectOfClass1, objectOfClass2] // object created form any class is supported here
let fuoundationList: [NSObject] = [NSString(""abc), NSNumber(123)] // object form apple's foundation library can go here
```
### Fetching FireStore Data and Merging With Structure:
```swift
// MARK : FireStore Getting Data
extension ChatViewController {
    func getFireStoreData() {
        let docRef = db.collection(K.FStore.collectionName)

        docRef.getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data()[K.FStore.senderField]!)")
                    let sender: String = document.data()[K.FStore.senderField]! as! String
                    let body: String = document.data()[K.FStore.bodyField]! as! String
                    let newMsg = Message(sender: sender, body: body)
                    self.messages.append(newMsg)
                    print(messages.count)
                    
                    // update the table view, also DispatchQueue to be extra safe side to confirm the background thread is synced into main thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
```

### Always Call Super.Func
Its a good practice to call the super.override-functions

### ViewController Lifecycle:
viewDidLoad() -> viewWillAppear() -> viewDidAppear() | just appeared visible -> viewWillDisappear() | stop animation or change UI -> viewDidDisappear() | last lifecycle

* viewDidDisappear() will be called after the next screen/controller's viewWillAppear()
* form segue, the next controller's ui properties cannot be changed directly, because the viewDidLoad() is not called yet.

### App Lifecycle:
App Launched -> App Visible -> App Recedes into background -> resources reclaimed
* AppDelegate.swift:
- (application:didFinishLaunchingWithOptions:)
* SceneDelegate.swift:
after ios 13 and iPadOS ... there is the ability to run multiple windows simultaneously. So there's this (SceneDelegate.swift) app lifecycle file along with previous AppDelegate.swift.
- sceneWillResignActive
- sceneDidEnterBackground
* Note: print(#function) will print the containing function name