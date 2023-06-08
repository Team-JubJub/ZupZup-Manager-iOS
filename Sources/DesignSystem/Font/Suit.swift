//
//  Suit.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/06/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

func Suit(weight: FontSet.Weight, size: FontSet.Size) -> Font {
    switch weight {
    case .thin:
        return .custom("SUIT-Thin", size: size.rawValue)
    case .extraLight:
        return .custom("SUIT-ExtraLight", size: size.rawValue)
    case .regular:
        return .custom("SUIT-Regular", size: size.rawValue)
    case .medium:
        return .custom("SUIT-Medium", size: size.rawValue)
    case .light:
        return .custom("SUIT-Light", size: size.rawValue)
    case .semibold:
        return .custom("SUIT-SemiBold", size: size.rawValue)
    case .bold:
        return .custom("SUIT-Bold", size: size.rawValue)
    case .extrabold:
        return .custom("SUIT-ExtraBold", size: size.rawValue)
    case .heavy:
        return .custom("SUIT-Heavy", size: size.rawValue)
    }
}
