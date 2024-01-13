//
//  Bundle-Decodable.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 1/5/24.
//

import Foundation

extension Bundle {
    /**
     * An extension function of Bundle, and is accessed by `let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")`
     * this fn accept a String as fileName and return a the generic type T
     */
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        // adding date decode policy. if there is a date property in decoding struct, it will preceed, if not found, it will be ignored
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd" // MM for month and mm for Minuites
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}

/**
 * And call this from other places of the app to load a file using
 * let astronauts = Bundle.main.decode("file-in-project-directory.extension")
 */
