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
    func asCurrencyWith5Decimals() -> String {
        let formatter = NumberFormatter()

        // Set number style to decimal
        formatter.numberStyle = .decimal
        
        guard let volumeNumber =  formatter.number(from: self) else { return "" }
        return currencyFormatter5.string(from: volumeNumber) ?? "$0.00"
    }
    
    /// Converts a Double into a Currency with 2 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // <- default value
        //formatter.currencyCode = "usd" // <- change currency
        //formatter.currencySymbol = "$" // <- change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Converts a Double into a Currency as a String with 2 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let formatter = NumberFormatter()

        // Set number style to decimal
        formatter.numberStyle = .decimal
        
        guard let volumeNumber =  formatter.number(from: self) else { return "" }
        return currencyFormatter2.string(from: volumeNumber) ?? "$0.00"
    }
    
    func formatNumberWithSuffix() -> String {
        guard let number = Double(self) else {
            return self
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        let trillion = 1_000_000_000_000.0
        let billion = 1_000_000_000.0
        let million = 1_000_000.0
        
        if number >= trillion {
            let formattedNumber = number / trillion
            return "\(numberFormatter.string(from: NSNumber(value: formattedNumber)) ?? "") trillion"
        } else if number >= billion {
            let formattedNumber = number / billion
            return "\(numberFormatter.string(from: NSNumber(value: formattedNumber)) ?? "") billion"
        } else if number >= million {
            let formattedNumber = number / million
            return "\(numberFormatter.string(from: NSNumber(value: formattedNumber)) ?? "") million"
        } else {
            return self
        }
    }
}
