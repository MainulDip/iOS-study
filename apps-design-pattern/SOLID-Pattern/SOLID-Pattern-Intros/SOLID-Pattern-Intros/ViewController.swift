//
//  ViewController.swift
//  SOLID-Pattern-Intros
//
//  Created by Mainul Dip on 5/15/25.
//

import UIKit

class ViewController: UIViewController {
    
    private var vm: SolidVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vm = SolidVM()
        
        self.view.backgroundColor = .green
    }


}

