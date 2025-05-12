//
//  Network.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 4/22/25.
//

import Foundation
import Combine

// intead of AnyPublisher<MovieResponse, Error> use some some Publisher<MovieResponse, Error>
// using `some` version, we don't need eraseToAnyPublisher() steep
func fetchMovies() -> some Publisher<MovieResponse, Error> {
    // TODO : Add Api Key From Movie Database | Done
    let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=\(ENV.API_Key)")!
    
    // "https://api.themoviedb.org/3/movie/popular?api_key=e0caebe93478b4082d595c82f9d4dc68&language=en-US&page=1"
    
    let publisher = URLSession
        .shared
        .dataTaskPublisher(for: url)
//    let chainPublisherOperators = publisher.map { (output) in output.data }
    // response handling
    let _ = publisher.map(\.response).print("publisher mapped response: ")
    let _ = publisher.map { output in
        let res = output.response as! HTTPURLResponse
        print("HTTPURLResponse statusCode: \(res.statusCode)")
    }
    let chainPublisherOperators = publisher.map(\.data)
    
    let decodeOutput = chainPublisherOperators.tryMap {
        data in
        print("hello")
        do {
            //let decodeData = try jsonDecoder.decode(MovieResponse.self, from: Data("".utf8)) // making intentional error to trigger the catch block
            let decodeData = try jsonDecoder.decode(MovieResponse.self, from: data)
            return decodeData
        } catch {
            print(error.localizedDescription)
            throw NetworkingError.decodingFailed("Decoding Failed and the error: \(error)")
        }
        
    }
    
//    let decodeOutput = chainPublisherOperators.decode(type: MovieResponse.self, decoder: jsonDecoder)
    
    return decodeOutput
    
//    let anyPublisher = decodeOutput.eraseToAnyPublisher()
//    
//    return anyPublisher
    
//    return URLSession
//        .shared
//        .dataTaskPublisher(for: url)
//        .map {(output) in output.data}
//        .decode(type: MovieResponse.self, decoder: jsonDecoder)
//        .eraseToAnyPublisher()
}

func searchMovies(for query: String) -> some Publisher<MovieResponse, Error> {
    let encodeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(ENV.API_Key)&query=\(encodeQuery)")!
    return URLSession
        .shared
        .dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: MovieResponse.self, decoder: jsonDecoder)
}


enum NetworkingError : Error {
    case decodingFailed(String)
}

func nfn() -> Never {
    fatalError()
}

func nfn() -> Void {
    print("Hello")
    return ()
}
