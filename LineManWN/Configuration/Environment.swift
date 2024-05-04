//
//  Environment.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 4/5/2567 BE.
//

import Foundation
enum URLManager {
    static var apiBaseURL: URL {
        URL(string: "https://api.coinranking.com/v2")!
    }
    
    static var apiKey: String {
        "coinrankingc4348cb2bf038bc49309d549c8103e3923d60d199adcfc6"
    }

}
