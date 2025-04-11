### code organization and use of class/struct `extension`:
when a ViewController gets long
- the initial class declaration should contain only stored properties and property observers. As `extension` can not contain stored and property observers `willSet/didSet`
- use `// MARK: <identification-comment>` before stored properties declaration, try to make similar properties live together.
- maintain same order of placement for related methods (linked with the properties) in the `extension`
- use separate extension to override methods for conforming protocol
- place `viewDidLoad` on the initial class or together with `viewWillTransition` in a separate extension

Get some extra quick code navigation from xcode's quick jump bar
```swift
// MARK: - This will show a line separator 
// TODO: Some Text
// FIXME: Some Text
```

### API keys:
Always store them in the server
For client do - `obfuscation`

### Swift Concurrency:
https://www.massicotte.org/concurrency-glossary

### Indi app developer case study:
https://swiftrocks.com/things-that-did-and-didnt-contribute-to-burnout-buddys-success.......