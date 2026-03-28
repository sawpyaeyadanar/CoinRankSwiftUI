//
//  CustomModifier.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 7/23/2567 BE.
//

import SwiftUI
struct LFont1WithSize16: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("LFont1"))
            .font(.custom("Roboto-Bold", size: 16.0))
    }
}
