//
//  Color+.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/02/20.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

extension Image {
    
    init(assetName: AssetName) {
        self.init(assetName.rawValue)
    }
}
