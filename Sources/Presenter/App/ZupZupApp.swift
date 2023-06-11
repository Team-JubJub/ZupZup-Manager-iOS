import SwiftUI

@main
struct ZupZupApp: App {
    
    // MARK: 생성자
    init() {
        FontSet.registerFonts() // 폰트를 등록합니다.
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
