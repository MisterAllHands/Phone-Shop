//
//  ListSection.swift
//  MultiSectionCompositionalLayout
//
//  Created by Emmanuel Okwara on 15.05.22.
//

import Foundation

enum ListSection {
    case category([ListItem])
    case hotSales([ListItem])
    case bestSeller([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .category(let items),
                .hotSales(let items),
                .bestSeller(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .category:
            return "Select Category"
        case .hotSales:
            return "Hot Sales"
        case .bestSeller:
            return "Best Seller"
        }
    }
    
    var title2: String {
        switch self{
        case .category:
            return "View all"
        case .hotSales:
            return "See"
        case .bestSeller:
            return "See"
        }
    }
}
