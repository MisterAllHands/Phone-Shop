//
//  ListItem.swift
//  MultiSectionCompositionalLayout
//
//  Created by Emmanuel Okwara on 15.05.22.
//

import Foundation

struct ListItem {
    
    let title: String
    let subtitle: String
    let urlToImage: URL?
    let imageData: Data? = nil
}

struct ProductItem {
    
    let CPU: String
    let camera: String
    let capacity: [String]
    let color: [String]
    let id: String
    let images: [String]?
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd: String
    let ssd: String
    let title: String
}
