//
//  CoinsModel.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import Foundation

struct CoinsReponse: Codable {
    let status: String
    let data: CoinsData
}
struct CoinsData : Codable {
    let coins : [Coin]?
}


struct Coin : Codable, Identifiable, Hashable {
    let uuid : String
    let symbol : String
    let name : String
    let color : String?
    let iconUrl : String
    let price : String
    let change : String
    let rank : Int
    var id: String { uuid }
    
    //let marketCap : String?
    //let listedAt : Int?
    //let sparkline : [String]?
    //let coinrankingUrl : String?
    //let twentyFourhVolume : String
    //let btcPrice : String?
    //let contractAddresses : [String]?
    
    
    var changeStatus: Bool {
        guard let changeValue = Double(change) else { return false }
        return changeValue > 0
    }
    
    var positiveChange: String {
        if let changeValue = Double(change) {
            let absoluteChange = abs(changeValue)
            return String(format: "%.2f", absoluteChange)
        } else {
            return "0.00"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        
        case uuid = "uuid"
        case symbol = "symbol"
        case name = "name"
        case color = "color"
        case iconUrl = "iconUrl"
        case price = "price"
        case change = "change"
        case rank = "rank"
        
        //case marketCap = "marketCap"
        //case listedAt = "listedAt"
        //case sparkline = "sparkline"
        //case coinrankingUrl = "coinrankingUrl"
        //case twentyFourhVolume = "24hVolume"
        //case btcPrice = "btcPrice"
        //case contractAddresses = "contractAddresses"
    }
    
    
}
