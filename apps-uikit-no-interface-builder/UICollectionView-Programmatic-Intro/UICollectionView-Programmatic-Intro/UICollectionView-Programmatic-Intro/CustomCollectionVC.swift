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
        
        // First thing for dynamic height and width , aka set auto sizing cell,
        // the logic for autosizing is in preferredLayoutAttributesFitting cells function
        (collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        // register the cell class
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: CellIdentifier.customCell)
        
        setupDelegation()
    }
    
    func setupDelegation() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataSource.names.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.customCell, for: indexPath) as! CustomCell
        
        // set dynamic label for the text view inside cell
        customCell.cellLabel?.text = DataSource.names[indexPath.item]
        customCell.ultimateSuperViewWidth = self.view.frame.width
        
        return customCell
    }
}

// MARK: delegation extension for setting static width and height (CGSize)
//extension CustomCollectionVC: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        view.layoutIfNeeded()
//        return CGSize(width: view.frame.width, height: view.systemLayoutSizeFitting(collectionViewLayout.collectionViewContentSize).height)
//    }
//}

// data extension
extension CustomCollectionVC {
    struct DataSource {
        static let names = ["First Name", "Second Name", "Third Name", "Set this constant as the value for the estimatedItemSize property to enable self-sizing cells for your collection view. This is a non-zero, placeholder value that tells the collection view to query each cell for its actual size using the cell’s preferredLayoutAttributesFitting(_:) method", "Fifth Name"]
    }
}

class CustomCell: UICollectionViewCell {
    
    var cellLabel: UILabel?
    var ultimateSuperViewWidth: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCell {
    func nameLabel(_ superView: UIView) -> UILabel {
        let label = UILabel()
        superView.addSubview(label)
        label.textAlignment = .center
        label.text = "Hello"
        label.numberOfLines = 0
        
        // setup aluto layout
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: superView.widthAnchor).isActive = true
        
        return label
    }
    
    func setupFrame() {
        contentView.backgroundColor = .yellow
        let cl = nameLabel(self.contentView)
        cellLabel = cl
        
//        print("\(String(describing: type(of: contentView)))")
    }
}


// Custom Cell Dynamic Height
extension CustomCell {
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout() // only this will not work
        layoutIfNeeded() // only this will work though
        
        // this will also work
        // layoutAttributes.frame.size = CGSize(width: contentView.superview?.superview?.frame.width ?? 0, height: cellLabel?.intrinsicContentSize.height ?? 0)
        
        // layoutAttributes.frame.size = CGSize(width: contentView.superview?.superview?.systemLayoutSizeFitting(cellLabel!.frame.size).width ?? 0, height: contentView.systemLayoutSizeFitting(cellLabel!.frame.size).height)
        
        // use injected superview
        layoutAttributes.frame.size = CGSize(width: ultimateSuperViewWidth!, height: contentView.systemLayoutSizeFitting(cellLabel!.frame.size).height)
        
        return layoutAttributes
    }
}
