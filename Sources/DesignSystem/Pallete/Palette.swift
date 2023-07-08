//
//  Pallete.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

enum Palette {
    // Ivory Gray
    case ivoryGray100
    case ivoryGray150
    case ivoryGray200
    case ivoryGray300
    case ivoryGray400
    case ivoryGray500
    case ivoryGray600
    case ivoryGray700
    case ivoryGray800
    
    // Cool Gray
    case coolGray100
    case coolGray200
    case coolGray300
    case coolGray400
    case coolGray500
    case coolGray600
    case coolGray700
    case coolGray800
    
    // Neutral Gray
    case neutralGray100
    case neutralGray150
    case neutralGray200
    case neutralGray250
    case neutralGray300
    case neutralGray400
    case neutralGray500
    case neutralGray600
    case neutralGray700
    case neutralGray800
    
    // Warm Gray
    case warmGray3
    case warmGray4
    case warmGray5
    case warmGray6
    
    // Yellow
    case yellow100
    case yellow200
    case yellow300
    case yellow400
    case yellow500
    case yellow600
    case yellow700
    case yellow800
    
    // Tangerine
    case Tangerine100
    case Tangerine200
    case Tangerine300
    case Tangerine400
    case Tangerine500
    case Tangerine600
    case Tangerine700
    case Tangerine800
    
    // Orange
    case orange100
    case orange200
    case orange300
    case orange400
    case orange500
    case orange600
    case orange700
    case orange800
    
    // Red
    case red100
    case red200
    case red300
    case red400
    case red500
    case red600
    case red700
    case red800
    
    // Teal
    case teal100
    case teal200
    case teal300
    case teal400
    case teal500
    case teal600
    case teal700
    case teal800
    
    // Cyan
    case cyan100
    case cyan200
    case cyan300
    case cyan400
    case cyan500
    case cyan600
    case cyan700
    case cyan800
    
    // Blue
    case blue100
    case blue200
    case blue300
    case blue400
    case blue500
    case blue600
    case blue700
    case blue800
    
    // Magenta
    case magenta100
    case magenta200
    case magenta300
    case magenta400
    case magenta500
    case magenta600
    case magenta700
    case magenta800
    
    // Green
    case green100
    case green200
    case green300
    case green400
    case green500
    case green600
    case green700
    case green800
    
    // Extra
    case pureBlack
    case pureWhite
    case Secondary
    case SecondaryText
    case ScrimBlack40
    
    var real: String {
        return String(describing: self)
    }
}
