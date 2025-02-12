//
//  VideoListVCViewController.swift
//  app-uitableview-programmatic-intro
//
//  Created by Mainul Dip on 2/9/25.
//

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
    // these are reqired protocol methods of the UITableViewDataSource
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
