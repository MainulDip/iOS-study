//
//  CustomViewController.swift
//  UICollectionView-Programmatic-Intro
//
//  Created by Mainul Dip on 2/12/25.
//

import UIKit

class CustomCollectionVC: UICollectionViewController {
    
    // Cell Identifier
    struct CellIdentifier {
        static let customCell = "CustomCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .orange
//        print("hello3")
        
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: CellIdentifier.customCell)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.customCell, for: indexPath)
        print("hello4")
        return customCell
    }
}

class CustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("hello")
//        setupFrame()
    }
    
    func setupFrame() {
        contentView.backgroundColor = .yellow
        print("hello2")
        print("\(String(describing: type(of: contentView)))")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
