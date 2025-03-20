### Initial Setup Storyboard:
Embedding a ViewController in `Tab Bar` will do the magic. To further add new controller as one of the `Tab Bar` item, `ctrl + drag` and select `relationship segue`.

To set a UINavigation Controller as one of the Tab-Bar's item > First embed a (separate) ViewController into UINavigationController > then the same `ctrl + drag` from the `Tab Bar` Controller to `UINavigationController`. 

### Setting Icons Storyboard:
As all VCs are mapped into `Tab Bar` Controller, each VC (Scene) will get an new entry (same level as `view`) to set it's `Tab Bar Item` section inside `Identity Inspector`. 

### Position Rearrangement:
Storyboard : Zoom into the `Tab Bar Controller` Scene's items and Drag left/right item to reposition.

### Changing Icons color:

### Left/Right Scrollable Bottom Tab Bar Item: