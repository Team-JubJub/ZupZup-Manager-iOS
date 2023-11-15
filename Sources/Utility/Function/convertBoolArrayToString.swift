//
//  convertBoolArrayToString.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 11/16/23.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

func convertBoolArrayToString(_ boolArray: [Bool]) -> String {
    guard boolArray.count == 7 else {
        return "FFFFFFF"
    }
    
    return boolArray.map { $0 ? "T" : "F" }.joined()
}
