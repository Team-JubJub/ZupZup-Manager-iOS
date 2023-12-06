//
//  SafariView.swift
//  ZupZupManager
//
//  Created by 정영진 on 2023/12/06.
//  Copyright © 2023 ZupZup. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}

#Preview {
    SafariView(url: URL(string: UrlManager.makeAccountUrl)!)
}
