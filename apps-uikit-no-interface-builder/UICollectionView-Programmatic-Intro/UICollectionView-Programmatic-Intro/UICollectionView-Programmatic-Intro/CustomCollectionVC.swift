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
        return 10000
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.customCell, for: indexPath)
        return customCell
    }
}

class CustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFrame()
    }
    
    func nameLabel(_ superView: UIView) -> UILabel {
        let label = UILabel()
        superView.addSubview(label)
        label.textAlignment = .center
        label.text = "Hello"
        
        // setup aluto layout
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        return label
    }
    
    func setupFrame() {
        contentView.backgroundColor = .yellow
        let _ = nameLabel(self.contentView)
        
//        print("\(String(describing: type(of: contentView)))")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
