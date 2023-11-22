//
//  Int+.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

extension Int {
    /// TimeMillis 형태를 yyyy/MM//dd HH:mm 형태로 반환
    /// - Returns: 1678610332530 -> 2023/03/24 12:33
    func dateFromMilliseconds() -> String {
        // 한국 시간으로 변환
        let date = Date(timeIntervalSince1970: TimeInterval(self) / 1000)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    func toString() -> String {
        return String(self)
    }
    
    func toPrice() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: self))
        return result! + "원"
    }
}
