//
//  FontSet.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation
import SwiftUI

/// 폰트를 관리하는 열거형
/// 폰트 / 사이즈 / 굴기 관리
enum FontSet {
    enum Name: String {
        case system
        case suite = "SUITE"
        case suit = "SUIT"
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
        case _34 = 34
    }
    
    enum Weight: String {
        case thin = "Thin"
        case extraLight = "ExtraLight"
        case heavy = "Heavy"
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case light = "Light"
        case semibold = "SemiBold"
        case extrabold = "ExtraBold"
        
        var real: Font.Weight {
            switch self {
            case .thin:
                return .thin
            case .extraLight:
                return .light
            case .light:
                return .light
            case .regular:
                return .regular
            case .medium:
                return .medium
            case .extrabold:
                return .bold
            case .bold:
                return .bold
            case .semibold:
                return .semibold
            case .heavy:
                return .heavy
            }
        }
    }
    
    struct CustomFont {
        private let _name: Name
        private let _weight: Weight
        
        init(_name: Name, _weight: Weight) {
            self._name = _name
            self._weight = _weight
        }
        
        var name: String {
            "\(_name.rawValue)-\(_weight.rawValue)"
        }
        
        var `extension`: String {
            "otf"
        }
    }
}

extension FontSet {
    /// 줍줍 사장님 앱에서 사용되는 폰트.
    /// Suite, Suit이 있습니다.
    /// 커스텀 폰트를 추가하고 싶을 경우, 아래의 배열에 추가해주면 됩니다.
    static var fonts: [CustomFont] {
        [
            CustomFont(_name: .suit, _weight: .thin),
            CustomFont(_name: .suit, _weight: .extraLight),
            CustomFont(_name: .suit, _weight: .light),
            CustomFont(_name: .suit, _weight: .regular),
            CustomFont(_name: .suit, _weight: .medium),
            CustomFont(_name: .suit, _weight: .semibold),
            CustomFont(_name: .suit, _weight: .bold),
            CustomFont(_name: .suit, _weight: .extrabold),
            CustomFont(_name: .suit, _weight: .heavy),
            CustomFont(_name: .suite, _weight: .light),
            CustomFont(_name: .suite, _weight: .regular),
            CustomFont(_name: .suite, _weight: .medium),
            CustomFont(_name: .suite, _weight: .semibold),
            CustomFont(_name: .suite, _weight: .bold),
            CustomFont(_name: .suite, _weight: .extrabold),
            CustomFont(_name: .suite, _weight: .heavy)
        ]
    }
    
    /// 폰트를 등록하는 함수
    /// 앱 실행시, 최초 한번만 실행됩니다.
    static func registerFonts() {
        fonts.forEach { font in
            FontSet.registerFont(fontName: font.name, fontExtension: font.extension)
        }
    }
    
    private static func registerFont(fontName: String, fontExtension: String) {
        guard let fontURL = Bundle(identifier: "com.ZupZupManager")?.url(
            forResource: fontName,
            withExtension: fontExtension
        ),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            debugPrint("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
            return
        }
        
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
