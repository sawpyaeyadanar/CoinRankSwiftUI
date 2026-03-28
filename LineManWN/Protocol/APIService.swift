//
//  APIService.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 7/17/2567 BE.
//

import Foundation
import Combine

protocol APICoinListService {
    func getCoinsList() -> AnyPublisher<CoinsReponse, any Error>
    func searchCoin(text: String) -> AnyPublisher<CoinsReponse, any Error>
    func getOfflineSearchList(text: String) -> AnyPublisher<CoinsReponse, APIError>
    func getOfflineCoinsList() -> AnyPublisher<CoinsReponse, any Error>
}

protocol APICoinDetailsService {
    func getCoinsDetails(uuid: String) -> AnyPublisher<CoinDetaisResponse, any Error>
}
