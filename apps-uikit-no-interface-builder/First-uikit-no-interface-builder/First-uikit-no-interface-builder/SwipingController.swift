//
//  SwipingController.swift
//  First-uikit-no-interface-builder
//
//  Created by Mainul Dip on 1/11/25.
//

import UIKit

class SwipingController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .green
        // collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: any UIViewControllerTransitionCoordinator) {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        // let isLandscape = size.width > size.height
    }
    // just type numberofitems and use auto complete
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // super.collectionView(collectionView, numberOfItemsInSection: section)
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // super.collectionView(collectionView, cellForItemAt: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
