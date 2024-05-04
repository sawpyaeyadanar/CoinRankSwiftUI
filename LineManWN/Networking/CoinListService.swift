//
//  CoinListService.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 3/5/2567 BE.
//

import Combine
import Foundation
import SwiftUI

class CoinListService {
    @Published var image: UIImage? = nil
    private var coinListCancellable: AnyCancellable?
    @Published var coinResponse: CoinsReponse? = nil
    
    init() {
        getCoinsList()
    }
    
    
    func getOfflineSearchList(text: String) -> AnyPublisher<CoinsReponse, APIError> {
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
    
    func searchCoin(text: String) -> AnyPublisher<CoinsReponse, any Error> {
        return NetworkingManager.request(.search, parameters: ["search": text])
              .tryMap({ data in
                  try JSONDecoder().decode(CoinsReponse.self, from: data)
              })
              .eraseToAnyPublisher()
    }
    
   
    func getOfflineCoinsList() -> AnyPublisher<CoinsReponse, APIError> {
        guard let url = Bundle.main.url(forResource: "CoinList", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let coinResult = try? JSONDecoder().decode(CoinsReponse.self, from: data)
        else { fatalError("Unable to Load Coin List") }
        return Just(coinResult)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    } 
    
    func getCoinsList() -> AnyPublisher<CoinsReponse, any Error> {
      return NetworkingManager.request(.list)
            .tryMap({ data in
              return  try JSONDecoder().decode(CoinsReponse.self, from: data)
            })
            .eraseToAnyPublisher()
            
            //.decode(type: CoinsReponse.self, decoder: JSONDecoder())
            //.receive(on: DispatchQueue.main)
            
        

//            .sink(receiveCompletion: NetworkingManager.handleCompletion,
//                  receiveValue: { [weak self] (response) in
//                self?.coinResponse = response
//                debugPrint(response.data.coins?.count ,"+++++++++++++++Get++++++++++++++++++")
//                self?.coinListCancellable?.cancel()
//            })
        
    }
    
    func getCoinsDetails() -> AnyPublisher<CoinDetaisResponse, APIError> {
        guard let url = Bundle.main.url(forResource: "CoinDetail", withExtension: "json") else {
            fatalError("Unable to Load Coin Detail")}
        do {
            let data = try Data(contentsOf: url)
            let coinResult = try JSONDecoder().decode(CoinDetaisResponse.self, from: data)
            return Just(coinResult)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
//        } catch let error {
//            debugPrint("error ", error.localizedDescription)
//            fatalError("Unable to Load Coin Detail")
//        }
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
        
        
//        guard let url = Bundle.main.url(forResource: "CoinDetail", withExtension: "json"),
//        let data = try? Data(contentsOf: url),
//              let coinResult = try? JSONDecoder().decode(CoinDetaisResponse.self, from: data)
//        else { fatalError("Unable to Load Coin Detail") }
//        return Just(coinResult)
//            .setFailureType(to: APIError.self)
//            .eraseToAnyPublisher()
    }
    
 
    
}
