//
//  PostData.swift
//  HackerNews
//
//  Created by Mainul Dip on 8/17/23.
//

import Foundation

struct Results: Decodable {
    var hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
