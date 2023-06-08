import SwiftUI

@main
struct ZupZupApp: App {
    
    init() {
        FontSet.registerFonts()
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
