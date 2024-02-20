//
//  RequestModel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/20/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

public struct RequestModel {
    let endPoints: EndPoints
    let body: Data?
    let requestTimeout: Float?
    
    public init(endPoints: EndPoints,
                requestBody: Encodable? = nil,
                requestTimeout: Float? = nil
    ) {
        self.endPoints = endPoints
        self.body = try? JSONEncoder().encode(requestBody!)
        self.requestTimeout = requestTimeout
    }
    
    public init(endPoints: EndPoints,
                body: Data?,
                requestTimeOut: Float?
    ) {
        self.endPoints = endPoints
        self.body = body
        self.requestTimeout = requestTimeOut
    }
    
    func getUrlRequest() -> URLRequest? {
        guard let url = endPoints.getUrl() else {
            return nil
        }
        
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = endPoints.method.rawValue
        
        for header in endPoints.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
}
