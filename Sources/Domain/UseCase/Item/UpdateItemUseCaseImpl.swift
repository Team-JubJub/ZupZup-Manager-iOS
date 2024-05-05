//
//  UpdateItemUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/05/05.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import UIKit
import Combine

final class UpdateItemUseCaseImpl: UpdateItemUseCase {
    
    
    // TODO: Remove Cancellables
    var cancellables = Set<AnyCancellable>()

    internal var service: ItemServiceProtocol
    
    init(service: ItemServiceProtocol = ItemService.shared) {
        self.service = service
    }
    
    func run(item: ItemEntity,
             image: UIImage,
             for itemId: Int,
             at storeId: Int) async throws -> Void {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            
            // TODO: Add Mapper
            let dto = UpdateItemDTO(
                itemid: item.itemId,
                item: UpdateItemDTO.Item(
                    itemName: item.name,
                    imageUrl: item.imageUrl,
                    itemPrice: item.priceOrigin,
                    salePrice: item.priceDiscount,
                    itemCount: item.count
                ),
                image: image
            )
            
            self.service.updateItem(dto, for: itemId, at: storeId)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    continuation.resume(returning: response)
                }
                .store(in: &cancellables)
        }
    }
}
