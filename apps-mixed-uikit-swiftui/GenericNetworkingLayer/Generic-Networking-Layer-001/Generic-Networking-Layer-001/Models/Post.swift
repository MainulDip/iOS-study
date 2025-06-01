//
//  Post.swift
//  Generic-Networking-Layer-001
//
//  Created by Mainul Dip on 5/30/25.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
