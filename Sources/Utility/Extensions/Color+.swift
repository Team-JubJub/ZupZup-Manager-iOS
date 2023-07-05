//
//  Color+.swift
//  ZupZupManager
//
//  Created by mctdev on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

extension Color {
    static func designSystem(_ color: Palette) -> Color? {
        Color(color.real)
    }
}
