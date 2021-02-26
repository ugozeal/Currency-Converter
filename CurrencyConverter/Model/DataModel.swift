//
//  File.swift
//  CurrencyConverter
//
//  Created by David U. Okonkwo on 2/26/21.
//

import Foundation

struct GetCurrency: Codable {
    var success: Bool
    var base: String
    var rates: [String: Double]

}
