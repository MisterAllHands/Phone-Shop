//
//  ListSection.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 4/12/22
//

import Foundation

enum ListSection {
    case category([HomeStore])
    case hotSales([HomeStore])
    case bestSeller([HomeStore])
    
    var items: [HomeStore] {
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
