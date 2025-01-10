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

        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Hello World!"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .boldSystemFont(ofSize: 19)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("From Viewcontroller");
        // Do any additional setup after loading the view.
        view.addSubview(logoImageView)
        view.addSubview(descriptionTextView)
        setupLayout()
    }
    
    private func setupLayout() {
//        view.backgroundColor = .yellow
        // imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        // this 'll place the image at the top-left x:0 y:0 cordinate with 50x50 height
        
        // auto layout tuning
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // 4 constran is necessay for non-intrinsic-size view, like tex2
        // the auto layout needs at least two constraints for views having an intrinsic size and at least four for views without having an intrinsic size
        
        descriptionTextView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }


}

