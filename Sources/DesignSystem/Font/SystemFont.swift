//
//  SystemFont.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/06/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
/// iOS 기본 시스템 폰트
/// - Parameters:
///   - size: 폰트의 크기
///   - weight: 폰트의 굴기
/// - Returns: 사용하고자 하는 시스템 폰트의 구조체를 반환합니다.
func SystemFont(size: FontSet.Size, weight: FontSet.Weight) -> Font {
    return .system(size: size.rawValue, weight: weight.real)
}
