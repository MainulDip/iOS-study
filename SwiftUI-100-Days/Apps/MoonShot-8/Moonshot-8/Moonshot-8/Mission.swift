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
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}


