//
//  PostData.swift
//  HackerNews
//
//  Created by Mainul Dip on 8/17/23.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    let id: String
    let objectID: String
    let points: Int
    let title: String
    let url: String
}
