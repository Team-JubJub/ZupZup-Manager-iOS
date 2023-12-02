//
//  functions.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/27.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

func splitTime(_ timeString: String) -> (hour: String, minute: String) {
    
    let components = timeString.split(separator: ":")
    
    guard components.count == 2, let hour = components.first, let minute = components.last else {
        return ("", "")
    }
    return (String(hour), String(minute))
}
