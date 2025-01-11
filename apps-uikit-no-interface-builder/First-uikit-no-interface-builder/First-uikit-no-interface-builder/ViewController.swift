//
//  ViewController.swift
//  First-uikit-no-interface-builder
//
//  Created by Mainul Dip on 1/7/25.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 255/255, green: 102/255, blue: 153/255, alpha: 1)
}

class ViewController: UIViewController {
    
        
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: .yummyFoodLogo)
        // auto layout enableing
        // adding border with round corner styling
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor(.red).cgColor
        imageView.layer.cornerRadius = 20
        // enable auto layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    let descriptionTextView: UITextView = {
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
        return textView
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        // let pinkColor = UIColor(red: 255/255, green: 102/255, blue: 153/255, alpha: 1)
        button.setTitleColor(UIColor.mainPink, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = UIColor.mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 202/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("From Viewcontroller");
        // Do any additional setup after loading the view.
        // view.addSubview(logoImageView)
        view.addSubview(descriptionTextView)
        
        setupBottomControls()
        setupLayout()
    }
    
    private func setupBottomControls() {
        // view.addSubview(previousButton)
        // previousButton.backgroundColor = .red
        // previousButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
//        let yellowView = UIView()
//        yellowView.backgroundColor = .yellow
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        
//        let blueView = UIView()
//        blueView.backgroundColor = .blue
        
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
    
    private func setupLayout() {
        let topImageContainerView = UIView()
//        topImageContainerView.backgroundColor = .blue
        view.addSubview(topImageContainerView)
        // topImageContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        // for testing this 'll place the image at the top-left x:0 y:0 cordinate with 50x50 height
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.addSubview(logoImageView)
        
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        
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
        
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 12).isActive = true // constant will behave like padding
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true // constant will behave like left padding here
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true // negative constant will behave like right padding here
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        print(UIDevice.current.orientation.rawValue)
        // get device orientation
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    
    @objc func orientationChanged() {
        print(UIDevice.current.orientation.rawValue)
    }
}

