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
        
        if let requestBody = requestBody {
                do {
                    self.body = try JSONEncoder().encode(requestBody)
                } catch {
                    print("Error encoding request body:", error)
                    self.body = nil
                }
            } else {
                self.body = nil
            }
        
//        self.body = try? JSONEncoder().encode(requestBody!)
        print("here!!!!")
        dump(requestBody)
        print("here!!!!")
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
        
        print("kkkkkkkk")
        print(self.body)
        print("kkkkkkkk")
        
        guard let url = endPoints.getUrl() else {
            // TODO: fix
            print("URL not Found")
            return nil
        }
        
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = endPoints.method.rawValue
        request.httpBody = self.body
        
        for header in endPoints.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        dump(request)
        
        return request
    }
}
