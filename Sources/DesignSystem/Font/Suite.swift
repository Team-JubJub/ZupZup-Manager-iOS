//
//  Suite.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/06/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

/// 줍줍에서 사용되는 SUITE 폰트
/// FontSet의 열거형을 참고할 것
/// - Parameters:
///   - weight: 글자의 굴기
///   - size: 글자의 크기
/// - Returns: 사용하고자하는 Font 구조체를 반환합니다.
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
