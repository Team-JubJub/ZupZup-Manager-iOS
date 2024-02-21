//
//  EndPoints.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2/20/24.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation

public protocol EndPoints {
    var baseURL: String { get }
    var path: String { get }
    var parameter: [URLQueryItem] { get }
    var headers: Headers { get }
    var method: HTTPMethodd { get }
    
    func getUrl() -> URL?
}

extension EndPoints {
    func getUrl() -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = baseURL
        component.path = path
        if !parameter.isEmpty { component.queryItems = parameter }
        component.port = 8080
        return component.url
    }
}

public typealias Headers = [String: String]

// TODO: Fix Naming
public enum HTTPMethodd: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum Environments: String, CaseIterable {
    case development
    case staging
    case production
}
