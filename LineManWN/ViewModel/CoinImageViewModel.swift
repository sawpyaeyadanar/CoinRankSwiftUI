//
//  CoinImageViewModel.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 3/5/2567 BE.
//

import Foundation
import Combine
import SwiftUI

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: Coins
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coins) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                
                self?.image = returnedImage
            }
            .store(in: &cancellables)
        
    }
    
}
