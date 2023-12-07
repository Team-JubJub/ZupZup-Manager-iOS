//
//  DeleteStoreView.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/07.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct DeleteStoreView: View {
    
    var store: Store<DeleteStoreState, DeleteStoreAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

//#Preview {
//    DeleteStoreView()
//}
