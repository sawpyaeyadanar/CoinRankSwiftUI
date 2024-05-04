//
//  CoinDetailsViewModel.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 3/5/2567 BE.
//
import Combine
import Foundation

class CoinDetailsViewModel: ObservableObject {
    
    @Published var coins: CoinDetails?
    private let apiService: CoinDetailService
    private var cancellable = Set<AnyCancellable>()
    var isFetching: Bool = false
    var errorMessage: String?
    var coin: Coins
//    var coin: Coins {
//        print("uuid \(coins?.uuid)")
//        print("symbol \(coins?.symbol)")
//        print("name \(coins?.name)")
//        print("color \(coins?.color)")
//        print("iconUrl \(coins?.iconURL)")
//        print("price \(coins?.price)")
//      
//        
//    return    Coins(uuid: coins!.uuid, symbol: coins!.symbol, name: coins!.name, color: coins?.color, iconUrl: coins!.iconURL, price: coins!.price, change: "", rank: 0)
//    }
    
    init(coin: Coins, service: CoinDetailService = CoinDetailService()) {
        self.coin = coin
        self.apiService = CoinDetailService()
        getCoinsDetails()
    }

    func getCoinsDetails()  {
      isFetching = true
        apiService.getCoinsDetails(uuid: coin.uuid)
        .sink { completion in
          self.isFetching =  false
          switch completion {
          case .finished:
            print(" getCoinsDetails successfully")
            
          case .failure(let error):
            print(" getCoinsDetails unable to fetch \(error)")
            self.errorMessage = error.localizedDescription
          }
        } receiveValue: { [weak self] coins in
            guard let self = self else { return  }
            self.coins = coins.data.coin
        }.store(in: &cancellable)
    }

}
