### Programmatic Project Setups:
Opting-out `interface-builder` and using the Programmatic UIKit needs initial project setup. 

- Delete `main.storyboard`
- From Project `General` ’s Targets select the app, then find `Deployment Info` > `supports multiple windows` > `Custom ios target properties` remove `Main` entry of the `Main Storyboard
- From `info.plist` delete `Storyboard Name` row (the project’s search functionality can also be used by searching for `main` and deleting that)
- Set `window` & `window?.windowScene` and `window?.rootViewController` after the `guard let windowScene`  and call `window?.makeKeyandVisible()` inside SceneDelegate

```swift
guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
```

### UITableView with predefined cell:

```swift
// TableViewController

import UIKit

class VideoTableViewVC: UIViewController {
    
    var tableView = UITableView()
    var videos: [Video] = []
    
    //storing value to reduce typo
    struct Cells {
        static let videoCell = "videoCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Video List"
        videos = fetchData() // populating videos
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        // setup delegates
        setTableViewDelegates()
        // setup heights
        tableView.rowHeight = 100
        tableView.backgroundColor = .yellow
        // register cells
        tableView.register(VideoCell.self, forCellReuseIdentifier: Cells.videoCell)
        // set constraints
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self // requires conforming to UITableViewDelegate protocol
        tableView.dataSource = self // requires conforming to UITableViewDataSource protocol
    }

}

extension VideoTableViewVC: UITableViewDelegate, UITableViewDataSource {
    // these are required protocol methods of the UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create your custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.videoCell) as! VideoCell
        let video = videos[indexPath.row]
        cell.set(video: video)
        return cell
    }
}

extension VideoTableViewVC {
    func fetchData() -> [Video] {
        let video1 = Video(image: Images.firstImage, title: "First Image")
        let video2 = Video(image: Images.secondImage, title: "Second Image")
        let video3 = Video(image: Images.thirdImage, title: "Third Image")
        let video4 = Video(image: Images.fourthImage, title: "Fourth Image")
        let video5 = Video(image: Images.fifthImage, title: "Fifth Image")
        let video6 = Video(image: Images.sixthImage, title: "Sixth Image")
        let video7 = Video(image: Images.seventhImage, title: "Seventh Image")
        let video8 = Video(image: Images.eighthImage, title: "Eight Image")
        let video9 = Video(image: Images.ninethImage, title: "Ninth Image")
        let video10 = Video(image: Images.tenthImage, title: "Tenth Image")
        return [video1, video2, video3, video4, video5, video6, video7, video8, video9, video10]
    }
}


// Video Cell
class VideoCell: UITableViewCell {
    
    var videoImageView = UIImageView()
    var videoTitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(videoImageView)
        addSubview(videoTitleLabel)
        
        configureImageView()
        configureLable()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(video: Video){
        videoImageView.image = video.image
        videoTitleLabel.text = video.title
    }
    
    func configureImageView() {
        videoImageView.layer.cornerRadius = 10
        videoImageView.clipsToBounds = true
        
    }
    
    func configureLable(){
        videoTitleLabel.numberOfLines = 0
        videoTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints(){
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        videoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        videoImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        videoImageView.widthAnchor.constraint(equalTo: videoImageView.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setTitleLabelConstraints(){
        videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        videoTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        videoTitleLabel.leadingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: 20).isActive = true
        videoTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        videoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}

```