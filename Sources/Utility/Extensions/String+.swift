//
//  String+.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/03/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import Foundation

extension String {
    
    /// DB에 있는 String형태의 state를 Enum으로 관리하기 위함
    var toReservationState: ReservationCondition {
        switch self {
        case "NEW":
            return ReservationCondition.new
        case "CONFIRM":
            return ReservationCondition.confirm
        case "COMPLETE":
            return ReservationCondition.complete
        case "CANCEL":
            return ReservationCondition.cancel
        default:
            return ReservationCondition.new
        }
    }
    
    func toPrice() -> String {
        guard let transformed = Int(self) else { return "" }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: transformed))
        return result!
    }
    
    func formatDateTimeRange() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let endDate = calendar.date(byAdding: .minute, value: 20, to: date)
            
            if let endDate = endDate {
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "HH:mm"
                
                let startTime = dateFormatter2.string(from: date)
                let endTime = dateFormatter2.string(from: endDate)
                
                return "\(startTime) ~ \(endTime)"
            }
        }
        
        return "정보 없음"
    }
}

extension String: Identifiable {
    public var id: String { return self }
}
