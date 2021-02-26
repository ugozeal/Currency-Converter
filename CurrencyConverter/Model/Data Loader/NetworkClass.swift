//
//  NetworkClass.swift
//  CurrencyConverter
//
//  Created by David U. Okonkwo on 2/26/21.
//

import Foundation
final class NetworkClass {
    static let shared = NetworkClass()
}

extension NetworkClass {
    
    func getData(success: @escaping (GetCurrency) -> (),  failure: @escaping (String) -> ()) {
        ApiClientWithHeaders.shared.loadData(requestType: .get, headers: ["Accept" : "application/json"], url: K.Url.url) { (successMessage) in
            success(successMessage)
        } failure: { (error) in
            failure(error)
        }

    }
    
    
}

