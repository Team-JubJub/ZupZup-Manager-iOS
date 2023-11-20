//
//  AppDelegate.swift
//  pinto
//
//  Created by mctdev on 2023/01/02.
//  Copyright © 2023 machete. All rights reserved.
//

import SwiftUI
import UserNotifications

import Firebase
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        FirebaseApp.configure()                                                 // 파이어 베이스 설정
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]      // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        // UNUserNotificationCenterDelegate를 구현한 메서드를 실행
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self                                   // 파이어베이스 Meesaging 설정
        
        let refreshToken = LoginManager.shared.getRefreshToken()
        
        if !refreshToken.isEmpty {
            let autoLoginRequest = AutoLoginRequest(refreshToken: refreshToken)
            
            AutoLoginRepository().autoLogin(request: autoLoginRequest) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        LoginManager.shared.autoLogin(response: response)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        LoginManager.shared.removeAccessToken()
                    }
                }
            }
        }
        return true
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
#if DEBUG
        print("APN 등록 실패 \n \(error.localizedDescription)")
#endif
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(                                                            // 백그라운드에서 푸시 알림을 탭했을 때 실행
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(                                                // Foreground(앱 켜진 상태)에서도 알림 오는 설정
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.list, .banner])
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?                           // 파이어베이스 MessagingDelegate 설정
    ) {
#if DEBUG
        print("⭐️FCM 토큰:\n \(String(describing: fcmToken))")
#endif
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        
        LoginManager.shared.setDeviceToken(newToken: fcmToken)
    }
}
