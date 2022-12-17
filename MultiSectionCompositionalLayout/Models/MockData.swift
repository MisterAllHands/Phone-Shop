//
//  MockData.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 4/12/22
//

import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private let category: ListSection = {
        
        .category([
            .init(title: "", subtitle: "",  urlToImage: URL(string: "")),
            .init(title: "", subtitle: "" , urlToImage: URL(string: "")),
            .init(title: "", subtitle: "" , urlToImage: URL(string: "")),
            .init(title: "",subtitle: "" , urlToImage: URL(string: "")),
            .init(title: "", subtitle: "" ,urlToImage: URL(string: ""))])
    }()
    
    private let hotSales: ListSection = {
        .hotSales([.init(title: "", subtitle: "", urlToImage: URL(string: "")),
                   .init(title: "", subtitle: "", urlToImage: URL(string: "")),
                   .init(title: "", subtitle: "", urlToImage: URL(string: ""))])
    }()
    
    private let bestSeller: ListSection = {
        .bestSeller([.init(title: "", subtitle: "", urlToImage: URL(string: "")),
                     .init(title: "", subtitle: "", urlToImage: URL(string: "")),
                     .init(title: "", subtitle: "", urlToImage: URL(string: "")),
                     .init(title: "", subtitle: "", urlToImage: URL(string: ""))])
    }()
    
    var pageData: [ListSection]{
        [category, hotSales, bestSeller]
    }
}
