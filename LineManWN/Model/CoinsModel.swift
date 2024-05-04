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
    let coins : [Coins]?
}


struct Coins : Codable, Identifiable, Hashable {
    let uuid : String
    let symbol : String
    let name : String
    let color : String?
    let iconUrl : String
    //let marketCap : String?
    let price : String
    //let listedAt : Int?
    let change : String
    let rank : Int
    //let sparkline : [String]?
    //let coinrankingUrl : String?
    //let twentyFourhVolume : String
    //let btcPrice : String?
    //let contractAddresses : [String]?
    var id: String { uuid }
    
    var changeStatus: Bool {
        guard let changeValue = Double(change) else { return false }
        return changeValue > 0
    }
    
    var positiveChange: String {
            if let changeValue = Double(change) {
                // Calculate the absolute value of the change
                let absoluteChange = abs(changeValue)
                // Format the absolute change value as a string
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
        //case marketCap = "marketCap"
        case price = "price"
        //case listedAt = "listedAt"
        case change = "change"
        case rank = "rank"
        //case sparkline = "sparkline"
        //case coinrankingUrl = "coinrankingUrl"
        //case twentyFourhVolume = "24hVolume"
        //case btcPrice = "btcPrice"
        //case contractAddresses = "contractAddresses"
    }

   
}
