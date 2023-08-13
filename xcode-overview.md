## Xcode Overview:
- Terminal : xcode doesn't have integrated terminal like vs-code or android studio, etc. Separate terminal is what it has.

- Integrated Docs : Unique Feature. All the developer's docs can be found of the "help" section of xcode.

### Major areas:
- Left (cmd 0) | Right | Bottom (Debug Area) (shift + cmd + y).

### Shortcuts:
- Build : cmd + r
- Code Suggestion : put the cursor inside a function and press "Esc"
- code indentation : ctrl + i 
- action center: cmd + alt + click || to embed, extract-subview (convert to reusable component), etc

### task
- clone view : alt/option drag
- view to IBOutlet Connection : ctrl + drag the arrow
- segue add : drag the top dot to another view, also give the segue an identifire
- zoon in 100% storyboard editor : ctrl + cmd + =
- zoom out : use the bottom zoom in/out button

### Code Indentations and beautification:
To refactor the code indentation (beatify/pretty), xcode requires you to select the code block and then editor -> Structure -> Re-indent 

### IBOutlet and IBActions's Connections UIs:
It is at the lat entry of the storyboard's view's attribute panel.
All IB connections are there. Disconnected connections should be removed. Otherwise there will be Error. Always clean the disconnected outlet.

### Using Environmental Variables:
Docs : https://www.swiftdevjournal.com/using-environment-variables-in-swift-apps/

### Creating Section In Xcode Overview
//MARK: - Some Texts

### Custom Code Snippet:
- select the code in xcode amd mark it as code snippet by right clicking
- integrate palceholder using <#Placeholder>
- and add the completion text | by what typing will trigger the code snippet

### Simulator Location Customizing
It's in Debug -> Simulator Location
Custom Location can be set to debug different things, like CoreLocations