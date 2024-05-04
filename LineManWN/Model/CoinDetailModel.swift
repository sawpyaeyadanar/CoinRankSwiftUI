//
//  CoinDetailModel.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import Foundation

struct CoinDetaisResponse: Codable {
    let status: String
    let data: CoinDetailsData
}

struct CoinDetailsData: Codable {
    let coin: CoinDetails
}

struct CoinDetails: Codable {
    let uuid, symbol, name, coinDescription: String
    let color: String
    let iconURL: String
    let websiteURL: String
    let marketCap, price: String
    /*
    let the24HVolume, fullyDilutedMarketCap: String
    let btcPrice: String
    let priceAt: Int
    let change: String
    let rank, numberOfMarkets, numberOfExchanges: Int
    let sparkline: [String]
    let allTimeHigh: AllTimeHigh
    let coinrankingURL: String
    let lowVolume: Bool
    let listedAt: Int
    let notices: [Notice]
    let tags: [String]
    let links: [Link]
    let supply: Supply
    */
    
    enum CodingKeys: String, CodingKey {

        case uuid = "uuid"
        case symbol = "symbol"
        case name = "name"
        case coinDescription = "description"
        case color = "color"
        case iconURL = "iconUrl"
        case websiteURL = "websiteUrl"
        case marketCap = "marketCap"
        case price = "price"
       
    }
}
//
//struct AllTimeHigh: Codable {
//    let price: String
//    let timestamp: Int
//}
//
//struct Link: Codable {
//    let name: String
//    let url: String
//    let type: String
//}
//
//struct Notice: Codable {
//    let type, value: String
//}
//
//struct Supply: Codable {
//    let confirmed: Bool
//    let supplyAt: Int
//    let circulating, total, max: String
//}
