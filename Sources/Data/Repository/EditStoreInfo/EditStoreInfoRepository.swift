//
//  EditStoreInfoRepository.swift
//  ZupZupManager
//
//  Created by YeongJin Jeong on 2023/07/28.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import UIKit

import Alamofire

final class EditStoreInfoRepository {
    
    let url = "https://zupzuptest.com:8080/seller/modification/\(LoginManager.shared.getStoreId())"
    
    let accessToken = LoginManager.shared.getAccessToken()
    
    func editStoreInfo(request: EditStoreInfoRequest, completion: @escaping (Result<EditStoreInfoResponse, NetworkError>) -> Void) {
        
        let headers: HTTPHeaders = [
            "accessToken": accessToken,
            "Content-Type": "multipart/form-data; boundary=\(UUID().uuidString)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            do {
                let jsonData = try JSONEncoder().encode(request.data)
                multipartFormData.append(jsonData, withName: "data", fileName: "data.json", mimeType: "application/json")
            } catch {
                completion(.failure(NetworkError.failToEncode))
                return
            }
            
            if let imageData = request.image.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            } else {
                completion(.failure(NetworkError.failToEncode))
                return
            }
        },
                  to: url,
                  headers: headers
        )
        .responseString { response in
            switch response.result {
            case .success:
                completion(.success(EditStoreInfoResponse()))
            case .failure:
                completion(.failure(NetworkError.invalidResponse))
            }
        }
    }
}
