//
//  Environment.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 4/5/2567 BE.
//

import Foundation
enum URLManager {
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {  fatalError("Plist file not found") }
        return dict
    }()
    
    static var apiBaseURL: URL {
        guard let urlString = URLManager.infoDictionary["Api Base Url"] as? String else {
            fatalError("Nothing found")
        }
        guard let url = URL(string: urlString) else {
            fatalError("Base URL is invalid")
        }
        return url
    }
    
    static var apiKey: String {
        guard let hostName = URLManager.infoDictionary["Authority Host"] as? String else { fatalError("Not Found") }
        return hostName
    }
}
