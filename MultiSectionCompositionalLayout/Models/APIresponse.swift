//
//  APIresponse.swift
//  PhoneShop
//
//  Created by TTGMOTSF on 05/12/2022.
//

import Foundation

struct APIresponse: Codable{
    
    let home_store: [HomeStoreItem]
    let best_seller: [BestSellerItem]
    
}

struct HomeStoreItem: Codable{
    
//    let id: Int?
//    let is_new: Bool?
    let title: String
    let subtitle: String
    let picture: String?
//    let is_buy: Bool?
 
    
}

struct BestSellerItem: Codable{
    
    let id: Int?
    let is_favorites: Bool
    let title: String
    let price_without_discount: Int
    let discount_price: Int
    let pictures: String

}
