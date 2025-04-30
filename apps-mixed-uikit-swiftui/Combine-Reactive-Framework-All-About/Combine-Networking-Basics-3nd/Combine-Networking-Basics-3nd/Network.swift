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
    // TODO : Add Api Key From Movie Database
    let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=\(ENV.API_Key)")!
    
    // "https://api.themoviedb.org/3/movie/popular?api_key=e0caebe93478b4082d595c82f9d4dc68&language=en-US&page=1"
    
    let publisher = URLSession
        .shared
        .dataTaskPublisher(for: url)
    let chainPublisherOperators = publisher.map { (output) in output.data }
    let decodeOutput = chainPublisherOperators.decode(type: MovieResponse.self, decoder: jsonDecoder)
    
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
