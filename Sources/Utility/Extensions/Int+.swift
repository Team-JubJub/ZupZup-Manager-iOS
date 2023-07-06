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
    
    /// Int형으로 시간을 String으로 변환합니다.
    /// - Returns: 1600 -> 16:00
    func makeDiscountTime() -> String {
        let startString = String(self)
        
        let startTime = {
            switch startString.count == 3 {
            case true:
                return startString.prefix(1)
            case false:
                return startString.prefix(2)
            }
        }()
            
        let startMinute = startString.suffix(2)
        return "\(startTime):\(startMinute)"
    }
    
    func toString() -> String {
        return String(self)
    }
}
