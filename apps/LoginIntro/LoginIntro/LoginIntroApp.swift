import SwiftUI

var isUserLoggedIn : Bool = true;

@main
struct LoginIntroApp: App {
    var body: some Scene {
        WindowGroup {
            if isUserLoggedIn {
                MainView()
            } else {
                LoginUIView()
            }
        }
    }
}
