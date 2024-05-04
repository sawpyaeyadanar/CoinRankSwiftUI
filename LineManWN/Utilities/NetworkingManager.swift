//
//  NetworkingManager.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 1/5/2567 BE.
//

import Foundation
import Combine

class NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case Unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                "Bad Response from URL \(url)"
            case .Unknown:
                "Unknown error occured"
            }
        }
    }
    
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        return   URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLRequest(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func request(_ endpoint: APIEndPoint, parameters: [String: String] = [:]) -> AnyPublisher<Data, any Error> {
        
        var urlComponent = endpoint.urlComponent
        urlComponent.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value)}
        
        var request = URLRequest(url: urlComponent.url!)
        request.url?.appendPathComponent(endpoint.path)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(URLManager.apiKey, forHTTPHeaderField: "X-Auth-Token")
        request.addHeaders(endpoint.headers)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        return   URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLRequest(output: $0, url: request.url!)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLRequest(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
