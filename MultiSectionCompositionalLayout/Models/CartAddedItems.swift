//
//  CartAddedItems.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 16/12/2022.
//

import Foundation

struct CartAddedItems: Codable{
    
    let basket: [Baskets]
    let delivery: String
    let id: String
    let total: Int
}

struct Baskets: Codable{
    
    let id: Int
    let images: String
    let price: Int
    let title: String
}
