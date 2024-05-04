//
//  SFSafariViewWrapper.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 4/5/2567 BE.
//

import SafariServices
import SwiftUI

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context _: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_: SFSafariViewController, context _: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {}
}
