//
//  APIService.swift
//  Generic-Networking-Layer-001
//
//  Created by Mainul Dip on 5/31/25.
//

import Foundation

enum APIError: Error {
    case urlSessionError(String)
    case serverError(String = "Invalid API key")
    case invalidResponse(String = "Invalid Response from server")
    case decodingError(String = "Decoding Error, Error persing server response")
    
}

protocol Service {
    func makeRequest<T: Codable> (with request: URLRequest, type: T.Type, completion: @escaping (T?, APIError?) -> Void)
}

class APIService: Service {
    func makeRequest<T: Codable>(with request: URLRequest, type: T.Type, completion: @escaping (T?, APIError?) -> Void) {
        //completion(nil, APIError.decodingError())
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(nil, .urlSessionError(error.localizedDescription))
                return
            }
            
            if let res = response as? HTTPURLResponse, res.statusCode > 299 {
                completion(nil, .serverError())
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidResponse())
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, nil)
            } catch let err {
                print(err)
                completion(nil, .decodingError())
                return
            }
            
            
        }
        .resume()
    }
    
    
}
