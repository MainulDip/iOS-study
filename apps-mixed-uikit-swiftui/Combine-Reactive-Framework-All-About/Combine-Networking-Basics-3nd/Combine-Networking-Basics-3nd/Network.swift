//
//  Network.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 4/22/25.
//

import Foundation
import Combine

func fetchMovies() -> AnyPublisher<MovieResponse, Error> {
    // TODO : Add Api Key From Movie Database
    let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=YOUR_API_KEY&language=en-US&page=1")!
    
    [1,2]
        .publisher
        .sink { _ in print("Request Sent") }
    
    return URLSession
        .shared
        .dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: MovieResponse.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}
