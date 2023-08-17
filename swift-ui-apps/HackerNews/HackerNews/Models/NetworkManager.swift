//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Mainul Dip on 8/17/23.
//

import Foundation

class NetworkManager {
    func fetchUrl() {
        if let theUrl = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: theUrl) { data, response, err in
                if let error = err {
                    print(error)
                    return
                }
                
                if let d = data {
                    print(d)
                    // perse json
                    let decoder = JSONDecoder()
//                    let parsedData = try decoder.decode(Results.self, from: d)
                    do {
                        let parsedData = try decoder.decode(Results.self, from: d)
                        DispatchQueue.main.async {
                            print(parsedData.hits)
                        }
                    } catch {
                        
                    }
                }
                
                if let res = response {
                    print(res)
                }
            }
            
            task.resume()
        }
    }
}
