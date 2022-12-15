//
//  ProductDetails.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 12/12/2022.
//

import Foundation

struct ProductDetails: Codable{
    
    let CPU: String
    let camera: String
    let capacity: [String]
    let color: [String]
    let id: String
    var images: [String]
    let isFavorites: Bool
    let price: Int
    var rating: Double
    let sd: String
    let ssd: String
    let title: String
}


