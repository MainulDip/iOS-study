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
        Page(imageName: "flower-unknown", headerText: "Welcome to First UIKit Third"),
    ]
    
    private lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        // let pinkColor = UIColor(red: 255/255, green: 102/255, blue: 153/255, alpha: 1)
        button.setTitleColor(UIColor.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            self.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }, completion: { _ in })
    }
    
    @objc private func handleNext() {
        print("Next button Tap \(pageControl.currentPage)")
        let nextPage = pageControl.currentPage + 1
        pageControl.currentPage = nextPage >= pages.count ? 0 : nextPage
        let indexPath: IndexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handlePrevious() {
        print("previous button Tap \(pageControl.currentPage)")
        let previous = pageControl.currentPage - 1
        pageControl.currentPage = previous < 0 ? pages.count : previous
        let indexPath: IndexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor.mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 202/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        
//        collectionView?.backgroundColor = .green
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView.isPagingEnabled = true
    }
    
    private func setupBottomControls() {
        let bottomControlStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlStackView.distribution = .fillEqually
        // bottomControlStackView.axis = .vertical
        
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomControlStackView)
        
        // alternate way of activating auto layout contraints
        NSLayoutConstraint.activate([
            //previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
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
