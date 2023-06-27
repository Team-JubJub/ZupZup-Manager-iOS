//
//  Suit.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/06/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

/// 줍줍에서 사용되는 SUIT 폰트
/// FontSet의 열거형을 참고할 것
/// - Parameters:
///   - weight: 글자의 굴기
///   - size: 글자의 크기
/// - Returns: 사용하고자하는 Font 구조체를 반환합니다.
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
