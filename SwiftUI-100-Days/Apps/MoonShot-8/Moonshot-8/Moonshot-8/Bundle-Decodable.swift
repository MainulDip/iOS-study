//
//  Bundle-Decodable.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 1/5/24.
//

import Foundation

extension Bundle {
    /**
     * An extension function that accept a Stirng as fileName and return array of a Dictionary
     */
    func decode(_ file: String) -> [String: Astronaut] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}

/**
 * And call this from other places of the app to load a file using
 * let astronauts = Bundle.main.decode("file-in-project-directory.extension")
 */
