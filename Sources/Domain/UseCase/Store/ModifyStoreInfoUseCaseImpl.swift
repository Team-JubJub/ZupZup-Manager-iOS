//
//  ModifyStoreInfoUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/05/03.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import UIKit
import Combine

final class ModifyStoreInfoUseCaseImpl: ModifyStoreinfoUseCase {
    
    var cancellables = Set<AnyCancellable>()
    
    internal var service: StoreServiceProtocol
    
    init(service: StoreServiceProtocol) {
        self.service = service
    }
    
    func run(store: StoreEntity,
             image: UIImage,
             at storeId: Int) async throws -> Void
    {
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
