//
//  ViewController.swift
//  gesture-recognizer-101
//
//  Created by Mainul Dip on 7/8/25.
//

import UIKit

class ViewController: UIViewController {
    
    let aRectView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .orange
        setupInnterView()
        
    }
    
    func setupInnterView() {
        aRectView.backgroundColor = .white
        aRectView.center = view.center
        view.addSubview(aRectView)
        listenSingleTap(view: aRectView)
        listenSwipping(view: aRectView)
    }
    
    func listenSingleTap(view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    func listenSwipping(view: UIView) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .right
        swipeGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(swipeGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        print("tapped")
    }
    
    @objc func handleSwipe(_ event: UIGestureRecognizer) {
        print("Swing right fired")
    }

}

