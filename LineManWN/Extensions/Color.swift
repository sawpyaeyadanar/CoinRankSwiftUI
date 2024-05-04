//
//  Color.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        guard let rgb = UInt64(hexString, radix: 16) else {
            self.init(red: 0, green: 0, blue: 0)
            return
        }
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

extension Color {
    static let listTheme = ColorListTheme()
    static let detailTheme = ColorDetailsTheme()
}

struct ColorListTheme {
    let font1 = Color("LFont1")
    let font2 = Color("LFont2")
    let font3 = Color("LFont3")
    let background = Color("Background")
    let shadow = Color("Shadow")
    let search = Color("Search")
}

struct ColorDetailsTheme {
    let font1 = Color("DFont1")
}
