//
//  convertDayStringToArray.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 11/16/23.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

func convertStringToBoolArray(_ inputString: String) -> [Bool] {
    guard inputString.count == 7 else {
        return [false, false, false, false, false, false, false]
    }
    
    return inputString.map { $0 == "T" }
}
