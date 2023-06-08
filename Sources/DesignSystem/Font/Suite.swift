//
//  Suite.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/06/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

func Suite(weight: FontSet.Weight, size: FontSet.Size) -> Font {
    switch weight {
    case .regular:
        return .custom("SUITE-Regular", size: size.rawValue)
    case .medium:
        return .custom("SUITE-Medium", size: size.rawValue)
    case .light:
        return .custom("SUITE-Light", size: size.rawValue)
    case .semibold:
        return .custom("SUITE-SemiBold", size: size.rawValue)
    case .bold:
        return .custom("SUITE-Bold", size: size.rawValue)
    case .extrabold:
        return .custom("SUITE-ExtraBold", size: size.rawValue)
    case .heavy:
        return .custom("SUITE-Heavy", size: size.rawValue)
    default:
        return .custom("SUITE-Medium", size: size.rawValue)
    }
}
