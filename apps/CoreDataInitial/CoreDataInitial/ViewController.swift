//
//  ViewController.swift
//  CoreDataInitial
//
//  Created by Mainul Dip on 8/27/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var container: NSPersistentContainer!
    // Note: place the container initialization code in SceneDelegate's scene:willConnectTo

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("NSPersistentContainer is : ", container.name)
        
        guard container != nil else {
            fatalError("This view needs a persistent container.")
        }
        // The persistent container is available.
    }


}

