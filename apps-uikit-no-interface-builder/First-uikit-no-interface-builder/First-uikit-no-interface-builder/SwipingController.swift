//
//  SwipingController.swift
//  First-uikit-no-interface-builder
//
//  Created by Mainul Dip on 1/11/25.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    let imageNames = ["yummy-food-logo", "girl-art", "flower-unknown", "rose"]
//    let headerString = ["Welcome to First UIKit", "No Interface Builder", "Just Code", "Enjoy"]
    
    let pages = [
        Page(imageName: "yummy-food-logo", headerText: "Welcome to First UIKit"),
        Page(imageName: "girl-art", headerText: "Welcome to First UIKit Second"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collectionView?.backgroundColor = .green
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: any UIViewControllerTransitionCoordinator) {
//        
//    }
//    
//    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
//        // let isLandscape = size.width > size.height
//    }
    // just type numberofitems and use auto complete
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // super.collectionView(collectionView, numberOfItemsInSection: section)
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // super.collectionView(collectionView, cellForItemAt: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! PageCell
//        cell.backgroundColor = .red
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
//        print("\(indexPath.item)")
//        let imageName = imageNames[indexPath.item]
//        cell.logoImageView.image = UIImage(named: imageName)
//        cell.descriptionTextView.text = headerString[indexPath.item]
        let index = indexPath.item
//        cell.logoImageView.image = UIImage(named: pages[index].imageName)
//        cell.descriptionTextView.text = pages[index].headerText
//        print(cell.descriptionTextView.attributedText?.string ?? "nothing for now")
        cell.page = pages[index]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
        // return CGSize(width: 100, height: 100)
    }
}
