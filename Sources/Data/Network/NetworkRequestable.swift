//
//  NetworkRequestable.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/20/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

public class NetworkRequestable: Requestable {
    public var requestTimeOut: Float = 30
    
    public func request<T>(_ req: RequestModel) -> AnyPublisher<T, NError> where T: Codable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeout ?? requestTimeOut)
        
        return URLSession.shared
            .dataTaskPublisher(for: req.getUrlRequest()!)
            .tryMap { output in
                
                guard output.response is HTTPURLResponse else {
                    // TODO: Fix
                    throw NError.badURL("Test")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                
                // TODO: Fix
                NError.apiError(code: 0, error: "Test")
            }
            .eraseToAnyPublisher()
    }
}
