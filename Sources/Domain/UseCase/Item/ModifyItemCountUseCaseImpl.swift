//
//  ModifyItemCountUseCaseImpl.swift
//  ZupZupManager
//
//  Created by 정영진 on 2024/05/05.
//  Copyright © 2024 ZupZup. All rights reserved.
//

import Foundation
import Combine

final class ModifyItemCountUseCaseImpl: ModifyItemCountUseCase {
    // TODO: Remove Cancellables
    var cancellables = Set<AnyCancellable>()

    internal var service: ItemServiceProtocol
    
    init(service: ItemServiceProtocol = ItemService.shared) {
        self.service = service
    }
    
    func run(items: [ItemEntity], at storeId: Int) async throws {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            
            // TODO: Add Mapper
            let dto = ModifyItemCountDTO(
                quantity: items.map {
                    ModifyItemCountDTO.Quantity(
                        itemId: $0.itemId,
                        itemName: $0.name,
                        imageURL: $0.imageUrl,
                        itemPrice: $0.priceOrigin,
                        salePrice: $0.priceDiscount,
                        itemCount: $0.count
                    )
                }
            )
            
            self.service.modifyItemCount(dto, at: storeId)
                .sink { completion in
                    // TODO: Error Handling
                    
                } receiveValue: { response in
                    continuation.resume(returning: response)
                }
                .store(in: &cancellables)
        }
    }
}
