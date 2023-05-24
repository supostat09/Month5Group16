//
//  NetworkService.swift
//  products
//
//  Created by Абдулла-Бек on 24/5/23.
//

import Foundation

struct NetworkService {
    let session = URLSession.shared
    let decoder = JSONDecoder()

    func fetchProducts() async throws -> [Product] {
        let url = URL(string: "https://dummyjson.com/products")!

        let (data, _) = try await URLSession.shared.data(from: url)
        let productsResponse = try decode(data: data, type: ProductResponse.self)
        return productsResponse.products
    }

    private func decode<T: Decodable>(data: Data, type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
