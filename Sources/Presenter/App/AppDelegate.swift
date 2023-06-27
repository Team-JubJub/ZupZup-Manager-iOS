//
//  AppDelegate.swift
//  pinto
//
//  Created by mctdev on 2023/01/02.
//  Copyright © 2023 machete. All rights reserved.
//

import SwiftUI
import FirebaseCore

// MARK: AppDelegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
