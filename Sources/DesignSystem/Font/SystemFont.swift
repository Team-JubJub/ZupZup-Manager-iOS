//
//  SystemFont.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/06/08.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

func SystemFont(size: FontSet.Size, weight: FontSet.Weight) -> Font {
    return .system(size: size.rawValue, weight: weight.real)
}
