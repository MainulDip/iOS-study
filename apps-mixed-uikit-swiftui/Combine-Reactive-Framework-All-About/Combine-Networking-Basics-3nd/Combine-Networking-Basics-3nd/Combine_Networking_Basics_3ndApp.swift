//
//  Combine_Networking_Basics_3ndApp.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 4/21/25.
//

import SwiftUI

@main
struct Combine_Networking_Basics_3ndApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


// MARK: - Storing API Keys Systemetic

class BaseEnv {
    let dict: NSDictionary
    
    init(resourceName: String){
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
        let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find resource file as \(resourceName).plist")
        }
        self.dict = plist
    }
}

protocol APIKeyable {
    // write all required API keys property
}

class DebugEnv: BaseEnv, APIKeyable {
    override init(resourceName: String) {
        super.init(resourceName: "Debug-keyS")
    }
}

class ProdEnv: BaseEnv, APIKeyable {
    override init(resourceName: String) {
        super.init(resourceName: "Prod-keyS")
    }
}
