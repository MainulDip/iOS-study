//
//  CustomViewController.swift
//  UICollectionView-Programmatic-Intro
//
//  Created by Mainul Dip on 2/12/25.
//

import UIKit

class CustomCollectionVC: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .orange
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
