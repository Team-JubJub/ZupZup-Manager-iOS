//
//  ModifyNoticeUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/04/29.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine
import UIKit

final class ModifyNoticeUseCaseImpl: ModifyNoticeUseCase {
    // TODO: Remove Cancellables
    var cancellables = Set<AnyCancellable>()

    internal var service: StoreServiceProtocol
    
    init(service: StoreServiceProtocol = StoreService.shared) {
        self.service = service
    }
    
    func run(at storeId: Int,
             notice: String,
             store: StoreEntity,
             image: UIImage) async throws -> Void {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            
            let dto = ModifyStoreInfoDTO(
                item: ModifyStoreInfoDTO.Item(
                    storeImageUrl: store.imageUrl,
                    openTime: store.openTime,
                    closeTime: store.closeTime,
                    saleTimeStart: store.saleStartTime,
                    saleTimeEnd: store.saleEndTime,
                    closedDay: convertBoolArrayToString(store.closedDay)
                ),
                image: image
            )
            
            self.service.modifyStoreinfo(dto, at: storeId)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    continuation.resume(returning: response)
                }
                .store(in: &cancellables)
        }
    }
}
