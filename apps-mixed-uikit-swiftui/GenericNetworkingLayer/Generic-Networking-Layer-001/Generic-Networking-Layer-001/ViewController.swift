//
//  ViewController.swift
//  Generic-Networking-Layer-001
//
//  Created by Mainul Dip on 5/30/25.
//

import UIKit

class ViewController: UIViewController {
    
    let service = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .yellow
        //        singleRequest()
        //        arrayRequest()
        postRequest()
    }
    
    private func singleRequest() {
        let request = Endpoint.fetchOnePost(postId: 7).request
        guard let request = request else {
            print("Request to buildable")
            return
        }
        service.makeRequest(with: request, type: Post.self) { (post, error) in
            if let error = error { print("DEBUG PRINT: \(error)"); return }
            
            guard let post = post else { print("Post is nil"); return }
            
            print("Single Post Title: \(post.title)"
            )
        }
    }
    
    private func arrayRequest() {
        let request = Endpoint.fetchPosts().request
        guard let request = request else {
            print("Request to buildable")
            return
        }
        service.makeRequest(with: request, type: [Post].self) { (posts: [Post]?, error) in
            if let error = error { print("DEBUG PRINT: \(error)"); return }
            posts?.forEach({
                print($0.title)
            })
        }
    }
    
    private func postRequest() {
        let newPost = Post(userId: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem voluptatem quaerat")
        let request = Endpoint.sendPost(post: newPost).request
        guard let request = request else {
            print("Request is not buildable")
            return
        }
        service.makeRequest(with: request, type: Post.self) { (post, error) in
            if let error = error { print("DEBUG PRINT: \(error)"); return }
            
            guard let post = post else { print("Post is nil"); return }
            
            print("Creating a new: \(post.title)"
            )
        }
    }
    
}

