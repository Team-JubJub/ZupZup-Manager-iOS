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
    case zupzupWarmGray1
    case zupzupWarmGray2
    case zupzupWarmGray3
    case zupzupWarmGray4
    case zupzupWarmGray5
    case zupzupWarmGray6
    case zupzupCoolGray1
    case zupzupIvoryGray500
    case Secondary
    case SecondaryText
    case BG_2
    case completeColor
    case confirmColor
    case OffWhite
    case warning1
    
    var hexString: String {
        switch self {
        case .zupzupMain:
            return "zupzupMain"
        case .zupzupWarmGray1:
            return "zupzupWarmGray1"
        case .zupzupWarmGray2:
            return "zupzupWarmGray2"
        case .zupzupWarmGray3:
            return "zupzupWarmGray3"
        case .zupzupWarmGray4:
            return "zupzupWarmGray4"
        case .zupzupWarmGray5:
            return "zupzupWarmGray5"
        case .zupzupWarmGray6:
            return "zupzupWarmGray6"
        case .zupzupIvoryGray500:
            return "zupzupIvoryGray500"
        case .zupzupCoolGray1:
            return "zupzupCoolGray1"
        case .Secondary:
            return "Secondary"
        case .SecondaryText:
            return "SecondaryText"
        case .BG_2:
            return "BG_2"
        case .completeColor:
            return "completeColor"
        case .confirmColor:
            return "confirmColor"
        case .OffWhite:
            return "OffWhite"
        case .warning1:
            return "warning1"
        }
    }
}
