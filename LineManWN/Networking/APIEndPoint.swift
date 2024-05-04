//
//  APIEndPoint.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 4/5/2567 BE.
//

import Foundation

typealias Headers = [String: String]
enum APIEndPoint {
    // MARK: - Cases
    case list
    case details( uuid: String)
    case search


    
    // MARK: - Properties
    var urlComponent: URLComponents {
        URLComponents(url: URLManager.apiBaseURL, resolvingAgainstBaseURL: false)!
        
    }

     var path: String {
        switch self {
        case .list:
            return "/coins"
        case let .details( uuid):
             return "/coins/\(uuid)/"
        case .search:
            return "/coins"
        }
    }
    
    var headers: Headers {
        [
            "Content-Type" : "application/json"
        ]
    }
    
     var httpMethod: HttpMethod {
        switch self {
        case .list, .details(_), .search:
            return .get
        }
    }
    
}
 extension URLRequest {
    mutating func addHeaders(_ headers: Headers) {
        headers.forEach { header, value in
            addValue(value, forHTTPHeaderField: header)
        }
    }
}
