//
//  Device.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct Device {
    static let Width = UIScreen.main.bounds.width
    static let Height = UIScreen.main.bounds.height
    static let WidthWithPadding = UIScreen.main.bounds.width * 358 / 390
    static let HeightWithPadding = UIScreen.main.bounds.height * 812 / 844
    static let VPadding = UIScreen.main.bounds.width * 16 / 390
    static let HPadding = UIScreen.main.bounds.height * 16 / 844
    static let cornerRadious = UIScreen.main.bounds.width * 14 / 390
}
