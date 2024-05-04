//
//  MainViewModel.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    @Published var coins: [Coins] = []
    @Published var topCoins: [Coins] = []
    @Published var specialIndices = [Int]()
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
    
    
    func getCoinsList()  {
      isFetching = true
        //coinListService.getCoinsList()
        coinListService.$coinResponse
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
            guard let self = self, let coins = coins?.data.coins else { return  }
            self.coins = coins
            self.specialIndices = calculateSpecialIndices(maxIndex: coins.count)
            self.getTopRank()
        }.store(in: &cancellable)
    }
    
    private func getTopRank() {
        self.topCoins = [Coins]()
        self.topCoins =  Array(coins.sorted { $0.rank < $1.rank }.prefix(3))
        // Remove top 3 ranks from coins array
        self.coins.removeAll { coin in
            self.topCoins.contains { $0.id == coin.id }
        }
        
    }
}
