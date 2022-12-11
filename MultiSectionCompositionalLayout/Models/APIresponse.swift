//
//  APIresponse.swift
//  PhoneShop
//
//  Created by TTGMOTSF on 05/12/2022.
//

import Foundation

//MARK: - Main Screen

struct APIresponse: Codable{
    
    let home_store: [HomeStoreItem]
    let best_seller: [BestSellerItem]
    
}

struct HomeStoreItem: Codable{
    
    let id: Int?
    let is_new: Bool?
    let title: String
    let subtitle: String
    let picture: String?
    let is_buy: Bool?
 
    
}

struct BestSellerItem: Codable{
    
    let id: Int?
    let is_favorites: Bool
    let title: String
    let price_without_discount: Int
    let discount_price: Int
    let picture: String?

}

//MARK: - Product Details

struct ProductDetails: Codable{
    
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


