//
//  ViewController.swift
//  First-uikit-no-interface-builder
//
//  Created by Mainul Dip on 1/7/25.
//

import UIKit

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
        textView.text = "Hello World!"
        // enable auto layout for this textView
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .boldSystemFont(ofSize: 19)
        textView.textAlignment = .center
        textView.isEditable = false // stop allowing text editing
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("From Viewcontroller");
        // Do any additional setup after loading the view.
        // view.addSubview(logoImageView)
        view.addSubview(descriptionTextView)
        setupLayout()
    }
    
    private func setupLayout() {
        let topImageContainerView = UIView()
        topImageContainerView.backgroundColor = .blue
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
        
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 12).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        print(UIDevice.current.orientation.rawValue)
        // get device orientation
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    
    @objc func orientationChanged() {
        print(UIDevice.current.orientation.rawValue)
    }
}

