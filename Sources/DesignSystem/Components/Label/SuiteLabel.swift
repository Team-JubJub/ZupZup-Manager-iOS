//
//  SuiteLabel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/04.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

struct SuiteLabel: View {
    
    let text: String
    let typo: TextType
    var color: Color? = .black
    
    var body: some View {
        Text(text)
            .font(Suite(weight: typo.real.weight, size: typo.real.size))
            .foregroundColor(color ?? .black)
    }
}

extension SuiteLabel {
    struct Typography {
        let size: FontSet.Size
        let weight: FontSet.Weight
    }
    
    enum TextType {
        case hero
        case h1
        case h2
        case h3
        case headline
        case body
        case callout
        case subhead
        case footnote
        case caption
        case captionSmall
        
        var real: Typography {
            switch self {
            case .hero:
                return Typography(size: ._34, weight: .heavy)
            case .h1:
                return Typography(size: ._28, weight: .heavy)
            case .h2:
                return Typography(size: ._22, weight: .heavy)
            case .h3:
                return Typography(size: ._20, weight: .heavy)
            case .headline:
                return Typography(size: ._17, weight: .heavy)
            case .body:
                return Typography(size: ._17, weight: .regular)
            case .callout:
                return Typography(size: ._16, weight: .regular)
            case .subhead:
                return Typography(size: ._15, weight: .regular)
            case .footnote:
                return Typography(size: ._13, weight: .regular)
            case .caption:
                return Typography(size: ._12, weight: .regular)
            case .captionSmall:
                return Typography(size: ._11, weight: .regular)
            }
        }
    }
}
