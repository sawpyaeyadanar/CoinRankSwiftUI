//
//  LineManWNApp.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import SwiftUI

@main
struct LineManWNApp: App {
    var body: some Scene {
        WindowGroup {
           // MainView(viewModel: MainViewModel())
            HomeView(viewModel: MainViewModel(coinListService: CoinListService()))
        }
    }
}
