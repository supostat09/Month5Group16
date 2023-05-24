//
//  MainViewModel.swift
//  products
//
//  Created by Абдулла-Бек on 24/5/23.
//

import Foundation

class MainViewModel {
    private let networkService = NetworkService()
    
    func fetchProducts() async throws -> [Product] {
        try await networkService
            .fetchProducts()
            .filter { product in
                product.price < 1000
            }
            .sorted(by: {
                $0.price > $1.price
            })
    }
}
