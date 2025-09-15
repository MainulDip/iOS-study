## All about ios Navigation:


### Navigation | Controller to Controller :
```swift
// initialize the controller and call self.present with the controller as one of its parameter.
```

### Navigation Storyboard, Cocoa Touch, Segue and Storybiard Segue Identifier :
- To perform Navigation based on storyboard design, Cocoa Touch Template can be used to make the view controller for it. 
- The newly created viewcontroller class name needs to be supplied inside storyboard's targeted scene's identity inspector's class properties name.
- Then to create a navigation direction a segue need to be created by holding ctrl and dragging a connection handle form Storyboard's view controller to view controller.
- After creating the segue connection, the segue connection itself needs an identifier which will be used to perform navigation suing self.performSegue form a ViewController class (btn action event usually).
- Sending Data form controller to controller : "override func prepare(for segue: UIStoryboardSegue, sender: Any?){}" is used. and segue.destination is used to get the destination controller object itself.
- Back Navigation: 
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

### Segue | element/btn to controller | controller to controller :
- element/btn to controller navigation using segue can be done using selecting the element/btn of a controller and ctrl + dragging into the destination view/controller, it does not require the segue identifiers (as those are unconditional direct navigation)
- controller to controller navigation using segue require to have identifier declared, what we will use to navigate if certain condition is match.
```swift
// call from controller
self.performSegue(...)
```
### Navigation Stack | Embedding in Navigation View Controller:
To get the back button and navigation stacking feature, the "entry point" view can set (embed in Navigation View Controller) by selecting and going through "Editor -> Embed in -> Navigation Controller" .
### Navigation Bar Button:
- Bar Button Item : A specialized button for placement on a toolbar, navigation bar, or shortcuts bar.
- Bar Button Item Group: Container form multiple Navigation Bar item
### Popping into root view navigation:
```swift
navigationController?.popToRootViewController(animated: true)
```
### Navigation Title and Hiding Specific (Back) Button
```swift
override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flash Chat"
        navigationItem.hidesBackButton = true
    }
```

### SwiftUI Navigation:
```swift
NavigationView {
    NavigationLink(destination: DetailView(url: post.url)) {
        Text("\(post.points): \(post.title)")
    }      
}
```
### Navigation Bar Buttons: