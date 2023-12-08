import SwiftUI

@main
struct ZupZupApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
//    init() {
//        FontSet.registerFonts() // 폰트를 등록합니다.
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
