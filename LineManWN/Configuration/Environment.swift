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
    
//    static var apiToken: String {
//        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OGYxNTdmMTJkOTI1OWFhMjVlZmE3YTk2OGVjMzU1ZCIsInN1YiI6IjY0ZDlhZTczMDAxYmJkMDBjNmM4MGQ2YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.daAlSowAw3X5oq7svCAdEIp6pQh_muDCzT6R9JUg6OA"
//    }
}
