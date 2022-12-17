//
//  CartAddedItems.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 16/12/2022.
//

import Foundation

struct CartAddedItems: Codable{
    
    let basket: [Basket]
    let delivery: String
    let id: String
    let total: Int
}

struct Basket: Codable {
    
    let id: Int
    let images: String
    let price: Int
    let title: String
}
