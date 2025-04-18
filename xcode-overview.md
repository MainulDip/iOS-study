## Xcode Overview:
- Terminal : xcode doesn't have integrated terminal like vs-code or android studio, etc. Separate terminal is what it has.

- Integrated Docs : Unique Feature. All the developer's docs can be found of the "help" section of xcode.

### Turn on/off AI code prediction:
Xcode > Preference/Setting > Text Editing > Editing

### Tips:
When writing code, keep open the `Inspector's quick help ?` (top right corner), it will give instant overview of any method/prop when cursor is placed into the code.
- `cmd + opt + 0` to toggle the inspector and `opt + cmd + left/right arrow` to navigate between inspector's options
- `ctrl + cmd + left` to navigate to the previous file (ie, when there are some error, the editor will be already change to the file that is throwing the error, the cause of the error is not that file obviously, so to switch back the editing file, use the keyword). For inspecting doc this kind of navigation is also handy, `ctrl+cmd+left/right` .......

### Major areas:
- Left (cmd 0) | Right | Bottom .
- right inspector panel (cmd + alt/option + 0)
- right preview area `cmd+alt+enter` to show/hide and `cmd+enter` to hide
- Show/Hide Bottom App Launcher Panel `cmd+alt+d`
- Debug Area (shift + cmd + y) [form remote desktop to mac form windows/linux]
- `cmd + enter` to show editor only. select inline comparison for comparing old and new code using version control's 

### SwiftUI Preview Area (Canvas):
- Show Preview -> alt/option + cmd + enter/return
- Hide Preview -> cmd + enter/return
- Refresh/Build Preview -> cmd + alt/option + p

### Code/Braces Tracking:
- Find the end of a block (closing braces): 
 1st click to select the beginning of braces (first brace), then double click to highlight the entire block

### Shortcuts
Some important shortcuts https://medium.com/@otufekci/xcode-shortcuts-that-makes-developers-life-easier-1740794a1d26

- `cmd + \` to create/delete a breakpoint to the active line of xcode
- `ctrl + cmd + <` to go back (when error happens and xcode been navigated to the error trigging file)
- `crl + shift + click` for multi cursor, selecting multiple line 
- `cmd + shift + l` (gui `view > show library`) import media (drag/drop) image, UIComponents/View etc 
- Indent/Re-Indent/Format Code : Ctrl + i 
- Build : cmd + r
- Code Suggestion : put the cursor inside a function and press "Esc" or `option + esc`
- code indentation : ctrl + i 
- action center: cmd + alt + click || to embed, extract-subview (convert to reusable component), etc
- esc: place the cursor on any function and press "esc" key to get the auto suggestions and quick look at the other options and params docs
- option + click : to see further docs of a function
- function override : no dedicated shortcut, use `ctrl+space` or `esc` or `opt+esc`. After overriden, from func block, press `ctrl+space` or `esc` to apply `super.func()` or else

- `cmd + N` for new file and `opt + cmd + n` for new folder/group/directory
- alt + right/left arrow -> to jump cursor to next/prev word quickly (ctrl + arrow) for windows/linux (Remote Desktop). 

- `cmd + shift + o` to open file in xcode editor 

- `Cmd + Shift + 0` — open docs and `cmd + w` to close docs (when focused)

- `cmd + shift + {/}` to select next previous tab

- `cmd + {/}` to indent (tab) code but placing the cursor at the end of line

- `opt + right/left arrow` to expand and collapse project directory.

`⌥ ⌘ E` or `opt + cmd + e` to select next occurrence of currently selected
`⌥ ⇧ ⌘ E` or `opt + shift + cmd + e` to select previous occurrence of currently selected
`⌥ ⌘ G` or `opt + cmd + g` to find and select next
`⌥ ⇧ ⌘ G` or `opt + shift + cmd + g` to find and select previous

### Implementing Protocol Member or overriding inheritance member:
- After Attaching the protocol, from inside struct/class braces, press `esc` for suggestion. Then apply those members

### task
- clone view : alt/option drag
- view to IBOutlet Connection : ctrl + drag the arrow.
- segue add : drag the top dot to another view, also give the segue an identifier
- zoon in 100% storyboard editor : ctrl + cmd + =
- zoom out : use the bottom zoom in/out button.

### Code Indentations and beautification
To refactor the code indentation (beatify/pretty), xcode requires you to select the code block and then editor -> Structure -> Re-indent, or `ctrl + i`. Ctrl is `^` mac

### IBOutlet and IBActions's Connections UIs
It is at the lat entry of the storyboard's view's attribute panel.
All IB connections are there. Disconnected connections should be removed. Otherwise there will be Error. Always clean the disconnected outlet.

### Using Environmental Variables
Docs : https://www.swiftdevjournal.com/using-environment-variables-in-swift-apps/

### Creating Section In Xcode Overviews:
// MARK: - Some Text
// TODO: - Some Text
// FIXME: - Some Text

### Custom Code Snippet:
- select the code in xcode amd mark it as code snippet by right clicking
- integrate placeholder using <#Placeholder>
- and add the completion text | by what typing will trigger the code snippet

### Simulator Location Customizing
It's in Debug -> Simulator Location
Custom Location can be set to debug different things, like CoreLocations

### Printing/Debugging on Debug Panel
- applying breakpoint will provide the interactive shell like interface. Use "print someVar" to print the values of the variable
### Code Scenes:
L: Local Variable (also maybe passed when extending another class)


### Assets.xcassets vs Preview Assets
Preview Assets as it is seen below just by default registered development time only catalog of resources.......

So you can store there any images, colors, files, ie any resources, which can be used in Preview Canvas only, for testing purpose. In example to not download one from internet, cloud, or fetch from database. Because Preview is for fast UI-only look & test, so data source is not important, so to test & tune UI you don't need to fetch external data but use locally stored test data

You can add/name any other development time asset/folder in there as well

### Importing and using assets/images:
From `Assets.xcassets` Images can be imported or dragged into. Each entry can support multiple (usually 3) variants for different device resolution. When dragging multiple images together, images suffixed with `@1..3x` will be sorted automatically, like `imagename@1x.jpeg` (`name@Nx.ext`)

After importing into xcassets, images can be imported predictable way where parameter accepts `UIImage?`
```swift
// once image is imported/dragged into Assets.xcassets 
let imageView2 = UIImageView(image: UIImage(named: "yummy-food-logo"))
let imageView = UIImageView(image: .yummyFoodLogo) // predictable way
```

Also `cmd + shift + l` (gui `view > show library`) import (drag/drop) image, UIComponents/View etc 

### Xcode not deleting code:

https://stackoverflow.com/questions/69352823/xcode-13-unable-to-remove-code-lines-after-deleting-derived-data


### xcode shortcut:
- `Opt + Cmd + N` — New Group or New Folder
- `cmd + n` - New File
- `Cmd + Shift + o` — Open Quickly, to go to - `particular line of file, type - `filename:line-number
- `Ctrl + Cmd + Opt + F` — to auto fix issues
- `Cmd + Shift + J`— Select file in navigator
- `Cmd + Shift + D`— Select file in debug view
- `Ctrl + Shift + Left arrow Key` — select word one by one towards left [divides camel case word and then select]
- `Ctrl + Shift + Right arrow Key` — select word one by one towards right
- `Opt + Shift + Left arrow Key` — select word one - by one towards left
- `Opt + Shift + Right arrow Key` — select word one - by one towards right
- `Cmd + Shift + Left/Right arrow Key` — goes to - the end of line
- `Cmd + Shift + L` — Open code snippets
- `Ctrl + 6` — To open jump menu
- `Cmd + Shift + Y` — Show/hide Debug region
- `Cmd + Ctrl + E` — Edit all within scope
- `Ctrl + space` — Show completions
- `Ctrl + .` — Show next suggestion
- `Cmd + /` — Comment Selection
- `Cmd + \` — Add breakpoint
- `Cmd + Y` — Activate/deactivate breakpoint
- `Cmd + K` -clear console
- `Cmd + Shift + K` — clean
- `Ctrl + K` — delete current line
- `Cmd + J` — Move Focus
- `Cmd + Shift + 0` — documentation
- `Cmd + U` — Run all tests
- `Cmd + Shift + U` — Run tests in current test suite
- `Cmd + Opt + Ctrl + G` — Test again
- `Cmd + Opt + Ctrl + U` — Run current test
- `Cmd + .` — detach simulator from Xcode
- `Ctrl + Shift + Up/Down` — MultiCursor editing
- `Cmd + ,` —> Open Preferences
- `Ctrl + L` — Center the current line to adjust screen position
- `Cmd + Opt + [ ]` — Move line up/down
- `Cmd + +` —> Make text bigger in editor
- `Cmd + —` ->Make text smaller in editor
- `Cmd + Ctrl + 0` — Reset text size
- `Ctrl + Cmd + ‘` — auto fix next error
- `Ctrl + Cmd + “` — auto fix prev error
- `Cmd + Opt + U` — Open scheme’s test settings
- `Cmd + Opt + R`— Open scheme’s run settings
- selected func + `ctrl + 1` will show context menu to select `callers` to see usages, also `ctrl + click`
### Mac Shortcut:
- `cmd + ctrl + f` Full-Screen Enter/Exit

### Simulator management:
Keep simulator on top : Simulator > Window > Stay on top and use `cmd + h` to hide
Simulator rotate : left `cmd + left-arrow` & right `cmd + right-arrow`

### Multiple window work:

Video aspect ratio 12:17 (IINA player in mac)