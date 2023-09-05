//
//  ViewController.swift
//  SeaFood
//
//  Created by Mainul Dip on 9/5/23.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // bind delegates
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] {
            imageView.image = (userPickedImage as? UIImageView)?.image
            print("User Image Selected \(imageView?.image?.size)")
        }
        
        imagePicker.dismiss(animated: true)
    }

    @IBAction func checkImage(_ sender: UIBarButtonItem) {
        print("Check btn pressed")
        present(imagePicker, animated: true, completion: nil)
    }
    
}

