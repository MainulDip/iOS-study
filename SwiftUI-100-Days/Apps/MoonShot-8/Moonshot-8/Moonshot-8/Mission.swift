//
//  Mission.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 1/10/24.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String? // its optional as sometimes we don't have this field in our missions.json file
    let crew: [CrewRole]
    let description: String
    
    // computed property for mission's display name
    var displayName: String {
        "Apollow \(id)"
    }
    
    // computed propety to get mission's image
    var image: String {
        get {
            "apollo\(id)"
        }
    }
}


