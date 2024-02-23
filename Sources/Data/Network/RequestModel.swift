//
//  RequestModel.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/20/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import UIKit
import Combine

public struct RequestModel {
    let endPoints: EndPoints
    var body: Data?
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
    
    public init(endPoints: EndPoints, 
                multipartBody: any Multipartable,
                multipartType: MultipartType,
                requestTimeout: Float? = nil,
                uniqueString: String
    ) {
        self.endPoints = endPoints
        self.requestTimeout = requestTimeout
        makeMulltipartBodyData(multipartBody, boundary: uniqueString, type: multipartType)
    }
    
    public init(endPoints: EndPoints,
                contentBody: ModifyItemCountDTO,
                requestTimeout: Float? = nil,
                uniqueString: String
    ) {
        self.endPoints = endPoints
        self.requestTimeout = requestTimeout
        makeContentBodyData(contentBody, boundary: uniqueString)
    }
}

extension RequestModel {
    func getUrlRequest() -> URLRequest? {
        
        guard let url = endPoints.getUrl() else {
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

extension RequestModel {
    
    public enum MultipartType: String {
        case item
        case data
    }
    
    private mutating func makeMulltipartBodyData<T: Multipartable>(_ dto: T, boundary: String, type: MultipartType) {
        
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(type.rawValue)\"; filename=\"\(type.rawValue).json\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
        body.append(try! JSONEncoder().encode(dto.item))
        body.append("\r\n".data(using: .utf8)!)
        
        if let imageData = dto.image.jpegData(compressionQuality: 0.8) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        self.body = body
    }
}

extension RequestModel {
    private mutating func makeContentBodyData(_ dto: ModifyItemCountDTO, boundary: String) {
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"quantity\"; filename=\"item.json\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
        body.append(try! JSONEncoder().encode(dto.quantity))
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        self.body = body
    }
}
