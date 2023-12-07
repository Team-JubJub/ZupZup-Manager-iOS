//
//  DeleteStoreState.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/07.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

// MARK: TCA-State
struct DeleteStoreState: Equatable {
    
}

// MARK: TCA-Action
enum DeleteStoreAction: Equatable {
    
    
}

// MARK: TCA-Environment
struct DeleteStoreEnvironment {
    
}

// MARK: TCA-Reducer
let deleteStoreReducer = AnyReducer<DeleteStoreState, DeleteStoreAction, DeleteStoreEnvironment> { state, action, environment in
    
    switch action {
    default:
        return .none
    }
}
