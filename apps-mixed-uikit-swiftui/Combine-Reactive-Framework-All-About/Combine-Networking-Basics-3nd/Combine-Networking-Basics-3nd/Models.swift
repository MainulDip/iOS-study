//
//  Movies.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 4/22/25.
//

import Foundation

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

// MARK: - Movies

struct Movie: Decodable, Equatable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    var posterURL: URL? {
        posterPath.map { URL(string: "https://image.tmdb.org/t/p/w500\($0)")! }
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

// MARK: - Credits

struct MovieCastMember: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    let character: String
}

struct MovieCreditsResponse: Decodable {
    let cast: [MovieCastMember]
}

// MARK: - Reviews Models

struct MovieReview: Identifiable, Equatable, Decodable {
    let id: Int
    let author: String
    let content: String
}

struct MovieReviewsResponse: Decodable {
    let results: [MovieReview]
}
