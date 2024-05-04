//
//  String.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import Foundation
extension String {
    
    /// Converts a Double into a Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.12345
    /// ```
    private var currencyFormatter5: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // <- default value
        //formatter.currencyCode = "usd" // <- change currency
        //formatter.currencySymbol = "$" // <- change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 5
        return formatter
    }
    
    /// Converts a Double into a Currency as a String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.12345"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let formatter = NumberFormatter()

        // Set number style to decimal
        formatter.numberStyle = .decimal
        
        guard let volumeNumber =  formatter.number(from: self) else { return "" }
        return currencyFormatter5.string(from: volumeNumber) ?? "$0.00"
    }
}
