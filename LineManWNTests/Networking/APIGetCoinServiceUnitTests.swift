//
//  APIGetCoinService.swift
//  LineManWNTests
//
//  Created by Saw Pyae Yadanar on 7/17/2567 BE.
//
import Combine
import Foundation

@testable import LineManWN

class APIGetCoinServiceUnitTests: APICoinListService {
    
    func getCoinsList() -> AnyPublisher<CoinsReponse, any Error> {
        guard let url = Bundle.main.url(forResource: "CoinList", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let coinResult = try? JSONDecoder().decode(CoinsReponse.self, from: data)
        else { fatalError("Unable to Load Coin List") }
        return Just(coinResult)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    
    func searchCoin(text: String) -> AnyPublisher<LineManWN.CoinsReponse, any Error> {
        guard let url = Bundle.main.url(forResource: "Search", withExtension: "json") else {
            fatalError("Unable to Search Coin")}
        do {
            let data = try Data(contentsOf: url)
            let coinResult = try JSONDecoder().decode(CoinsReponse.self, from: data)
            return Just(coinResult)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            fatalError("Unable to Load Coin Detail")
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            fatalError("Unable to Load Coin Detail")
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            fatalError("Unable to Load Coin Detail")
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            fatalError("Unable to Load Coin Detail")
        } catch {
            print("error: ", error)
            fatalError("Unable to Load Coin Detail")
        }
    }
    
    func getOfflineSearchList(text: String) -> AnyPublisher<LineManWN.CoinsReponse, LineManWN.APIError> {
        guard let url = Bundle.main.url(forResource: "Search", withExtension: "json") else {
            fatalError("Unable to Search Coin")}
        do {
            let data = try Data(contentsOf: url)
            let coinResult = try JSONDecoder().decode(CoinsReponse.self, from: data)
            return Just(coinResult)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            fatalError("Unable to Load Coin Detail")
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            fatalError("Unable to Load Coin Detail")
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            fatalError("Unable to Load Coin Detail")
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            fatalError("Unable to Load Coin Detail")
        } catch {
            print("error: ", error)
            fatalError("Unable to Load Coin Detail")
        }
    }
}
