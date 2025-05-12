//
//  Combine_Networking_Basics_3ndApp.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 4/21/25.
//

import SwiftUI

var ENV: APIKeyable {
#if DEBUG
    return DebugEnv()
#else
    return ProdEnv()
#endif
}

@main
struct Combine_Networking_Basics_3ndApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MoviesView()
                    .onAppear {
                        print(ENV.API_Key)
                        // publisherOfPublisher()
                        publisherOfPublisherWithFlatMap()
                    }
                //            PreferenceKeyEg()
                //            PreferenceOnButtonPress()
            }
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
    var API_Key: String { get }
}

class DebugEnv: BaseEnv, APIKeyable {
    var API_Key: String {
        dict.object(forKey: "TMDB_API_Key") as! String
    }
    
    init() {
        super.init(resourceName: "Debug-keys")
    }
}

class ProdEnv: BaseEnv, APIKeyable {
    var API_Key: String {
        dict.object(forKey: "TMDB_API_Key") as! String
    }
    
    init() {
        super.init(resourceName: "Prod-keys")
    }
}

