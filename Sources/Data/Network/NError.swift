//
//  NError.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/20/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

public enum NError: Error, Equatable {
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
}
