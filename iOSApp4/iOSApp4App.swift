import SwiftUI
import FirebaseCore

@main
struct iOSApp4: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
