//
//  PageCell.swift
//  First-uikit-no-interface-builder
//
//  Created by Mainul Dip on 1/16/25.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
//            print(page!.imageName)
            guard let page = page else { return }
            logoImageView.image = UIImage(named: page.imageName)
            descriptionTextView.text = page.headerText
        }
    }
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: .yummyFoodLogo)
        // auto layout enableing
        // adding border with round corner styling
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor(.red).cgColor
        imageView.layer.cornerRadius = 20
        // enable auto layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill

        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        // enable auto layout for this textView
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // textView.text = "Hello World!"
        // textView.font = .boldSystemFont(ofSize: 19)
        
        // using farther configuration using `UITextView().attributedText`
        let attributedText = NSMutableAttributedString(string: "Hello World", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        attributedText.append(NSAttributedString(string: "\n\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
        
        textView.attributedText = attributedText
        
        textView.textAlignment = .center
        textView.isEditable = false // stop allowing text editing
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .purple
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let topImageContainerView = UIView()
//        topImageContainerView.backgroundColor = .blue
        addSubview(topImageContainerView)
        // topImageContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        // for testing this 'll place the image at the top-left x:0 y:0 cordinate with 50x50 height
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.addSubview(logoImageView)
        
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        
        // auto layout tuning for logoImageView
        logoImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        // logoImageView.topAnchor.constraint(equalTo: topImageContainerView.topAnchor, constant: 100).isActive = true
         logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
         logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        // logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        // // auto layout tuning for descriptionTextView
        // 4 constran is necessay for non-intrinsic-size view, like text
        // the auto layout needs at least two constraints for views having an intrinsic size (image) and at least four for views with no intrinsic size (text>
        // let isLandscape = self.view.frame.width > self.view.frame.height
//
        addSubview(descriptionTextView)
        let isLandscape = frame.width > frame.height
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 12).isActive = true // constant will behave like padding
        
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: !isLandscape ? 80 : 160).isActive = true // constant will behave like left padding here
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: !isLandscape ? -80 : -160).isActive = true // negative constant will behave like right padding here
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        // nextButton.addTarget(self, action: #selector(ViewController.didSelectNext(_:)), for: .touchDown)
    }
}
