//
//  LineManWNTests.swift
//  LineManWNTests
//
//  Created by Saw Pyae Yadanar on 7/17/2567 BE.
//

import XCTest
@testable import LineManWN

final class LineManWNTests: XCTestCase {

    var homeViewModel: HomeViewModel!
    var detailViewModel: CoinDetailsViewModel!
    
    override func setUpWithError() throws {
        homeViewModel = .init(coinListService: APIGetCoinServiceUnitTests())
        detailViewModel = .init(coin: Coin(uuid: "21213", symbol: "", name: "", color: nil, iconUrl: "", price: "", change: "", rank: 0), service: APICoinDetailServiceUnitTests())
    }
    
    override func tearDownWithError() throws {
        homeViewModel = nil
        detailViewModel = nil
    }
    
    func test_getCoinList() throws {
        homeViewModel.getCoinsList()
         XCTAssertEqual(homeViewModel.coins.count, 8)
    }
    
    func test_coinDetails() throws {
        detailViewModel.getCoinsDetails()
        XCTAssertNotNil(detailViewModel.coin)
    }
}
