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
    //case search


    
    // MARK: - Properties
    var urlComponent: URLComponents {
        URLComponents(url: URLManager.apiBaseURL, resolvingAgainstBaseURL: false)!
        
    }

     var path: String {
        switch self {
        case .list:
            return "/coins"
        case let .details( uuid):
        //https://api.coinranking.com/v2/coin/:uuid
             return "/coins/\(uuid)/"
        }
    }
    
    var headers: Headers {
        [
            "Content-Type" : "application/json"
        ]
    }
    
     var httpMethod: HttpMethod {
        switch self {
        case .list, .details(_):
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
