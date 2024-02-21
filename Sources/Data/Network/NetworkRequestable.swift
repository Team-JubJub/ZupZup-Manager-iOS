//
//  NetworkRequestable.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/21/24.
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
                // TODO: Fix
                dump(output)
                guard output.response is HTTPURLResponse else {
                    // TODO: Fix
                    throw NError.badURL("Test2")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                // TODO: Fix
                dump(error.localizedDescription)
                // TODO: Fix
                return NError.apiError(code: 0, error: "Test1")
            }
            .eraseToAnyPublisher()
    }
}
