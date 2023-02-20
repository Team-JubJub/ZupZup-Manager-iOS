//
//  Device.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
/// 기기 변화에 유동적으로 대응하기 위해 Ratio 기반의 UI를 구성합니다.
/// ScreenWidth: 기기의 가로, ScreenHeight: 기기의 세로
struct Device {
    static let Width = UIScreen.main.bounds.width
    static let Height = UIScreen.main.bounds.height
    static let VerticalPadding = UIScreen.main.bounds.height * 16 / 844
    static let horizontalPadding = UIScreen.main.bounds.height * 16 / 844
}

