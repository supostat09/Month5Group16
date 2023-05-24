//
//  Product.swift
//  products
//
//  Created by Абдулла-Бек on 24/5/23.
//

import Foundation

struct ProductResponse: Codable {
    var products: [Product]
}

struct Product: Codable {
    var id: Int
    var title: String
    var description: String
    var price: Int
    var thumbnail: String
}
