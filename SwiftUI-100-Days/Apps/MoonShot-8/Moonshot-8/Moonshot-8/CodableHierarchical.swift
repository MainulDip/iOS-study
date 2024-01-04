//
//  CodableHierarchical.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 1/4/24.
//

import SwiftUI

struct CodableHierarchical: View {
    var body: some View {
        Button("Decode JSON") {
            // let data = input.data(using: .utf8) // returns optional
            let data = Data(input.utf8) // doesn't return optional
            
            let decoder = JSONDecoder()
            
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

let input = """
    {
        "name": "Taylor Swift",
        "address": {
            "street": "555, Taylor Swift Avenue",
            "city": "Nashville"
        }
    }
    """

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

#Preview {
    CodableHierarchical()
}
