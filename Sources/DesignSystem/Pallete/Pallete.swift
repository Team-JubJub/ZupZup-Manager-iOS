//
//  Pallete.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

enum Palette {
    case zupzupMain
    case zupzupWarmGray3
    case zupzupWarmGray4
    case zupzupWarmGray5
    
    var hexString: String {
        switch self {
        case .zupzupMain:
            return "zupzupMain"
        case .zupzupWarmGray3:
            return "zupzupWarmGray3"
        case .zupzupWarmGray4:
            return "zupzupWarmGray4"
        case .zupzupWarmGray5:
            return "zupzupWarmGray5"
        }
    }
}
