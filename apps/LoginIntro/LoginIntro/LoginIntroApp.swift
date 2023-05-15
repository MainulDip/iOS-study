import SwiftUI

var isUserLoggedIn : Bool = false;

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
