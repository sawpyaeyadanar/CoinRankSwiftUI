//
//  MainViewModel.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var coins: [Coin] = []
    @Published var topCoins: [Coin] = []
    @Published var specialIndices = [Int]()
    @Published var searchText: String = ""
    @Published var searchCoin: [Coin] = []
    @Published var isSearching: Bool = false
    
    private let coinListService: CoinListService
    private var cancellable = Set<AnyCancellable>()
    var isFetching: Bool = false
    var errorMessage: String?
    
    init(coinListService: CoinListService) {
        self.coinListService = CoinListService()
        getCoinsList()
    }
    
    private func calculateSpecialIndices(maxIndex: Int) -> [Int] {
        var indices: [Int] = []
        var index = 5
        
        while index < maxIndex {
            indices.append(index - 1)
            index *= 2
        }
        return indices
    }
    
    func getSearchList(text: String)  {
        self.searchCoin = [Coin]()
        self.isSearching = true
        self.isFetching = true
        coinListService.getOfflineSearchList(text: text)
        //  coinListService.searchCoin(text: text)
          .sink { completion in
            self.isFetching =  false
            switch completion {
            case .finished:
              print("search coin successfully")
              
            case .failure(let error):
              print(" search coin unable to fetch \(error)")
                self.errorMessage = error.localizedDescription
            }
          } receiveValue: { [weak self] coins in
              guard let self = self, let coins = coins.data.coins else { return }
              self.searchCoin = coins
              self.specialIndices = calculateSpecialIndices(maxIndex: coins.count)
          }.store(in: &cancellable)
    }
    
    func finishSearch() {
        self.isSearching = false
    }
  
    
    func getCoinsList()  {
        
      isFetching = true
        //coinListService.getOfflineCoinsList()
        //coinListService.$coinResponse
        coinListService.getCoinsList()
        .sink { completion in
          self.isFetching =  false
          switch completion {
          case .finished:
            print("getCoinsList successfully")
          case .failure(let error):
            print(" getCoinsList unable to fetch \(error)")
              self.errorMessage = error.localizedDescription
          }
        } receiveValue: { [weak self] coins in
            guard let self = self, let coins = coins.data.coins else { return  }
            self.coins = coins
            self.specialIndices = calculateSpecialIndices(maxIndex: coins.count)
            self.getTopRank()
        }.store(in: &cancellable)
    }
    
    private func getTopRank() {
        self.topCoins = [Coin]()
        self.topCoins =  Array(coins.sorted { $0.rank < $1.rank }.prefix(3))
        self.coins.removeAll { coin in
            self.topCoins.contains { $0.id == coin.id }
        }
    }
}
