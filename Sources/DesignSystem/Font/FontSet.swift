//
//  FontSet.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation
import SwiftUI

enum FontSet {
    enum Name: String { // 글자의 종류
        case system
    }
    
    enum Size: CGFloat { // 글자 크기
        case _10 = 10
        case _11 = 11
        case _12 = 12
        case _13 = 13
        case _14 = 14
        case _15 = 15
        case _16 = 16
        case _17 = 17
        case _18 = 18
        case _20 = 20
        case _22 = 22
    }
    
    enum Weight: String { // 글자의 진함
        case heavy = "Heavy"
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case light = "Light"
        case semibold = "SemiBold"
        
        var real: Font.Weight {
            switch self {
            case .heavy:
                return .heavy
            case .bold:
                return .bold
            case .medium:
                return .medium
            case .regular:
                return .regular
            case .light:
                return .light
            case .semibold:
                return .semibold
            }
        }
    }
}

func SystemFont(size: FontSet.Size, weight: FontSet.Weight) -> Font {
    return .system(size: size.rawValue, weight: weight.real)
}
