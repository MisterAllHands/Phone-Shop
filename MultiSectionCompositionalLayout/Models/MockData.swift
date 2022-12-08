//
//  MockData.swift
//  MultiSectionCompositionalLayout
//
//  Created by Emmanuel Okwara on 21.05.22.
//

import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private let category: ListSection = {
        .category([
            .init(title: "", subtitle: "", image: "1", urlToImage: URL(string: "")),
            .init(title: "", subtitle: "" ,image: "2", urlToImage: URL(string: "")),
            .init(title: "", subtitle: "" , image: "3", urlToImage: URL(string: "")),
            .init(title: "",subtitle: "" , image: "4", urlToImage: URL(string: "")),
            .init(title: "", subtitle: "" ,image: "5", urlToImage: URL(string: ""))])
    }()
    
    private let hotSales: ListSection = {
        .hotSales([.init(title: "Naruto", subtitle: "Super.Mega.Rapido.", image: "popular-1", urlToImage: URL(string: "")),
                   .init(title: "Jujutsu Kaisen", subtitle: "Super.Mega.Rapido.", image: "popular-2", urlToImage: URL(string: "")),
                   .init(title: "Demon Slayer", subtitle: "Super.Mega.Rapido.", image: "popular-3", urlToImage: URL(string: "")),
                   .init(title: "One Piece", subtitle: "Super.Mega.Rapido.", image: "popular-4", urlToImage: URL(string: "")),
                   .init(title: "Seven Deadly Sins", subtitle: "Super.Mega.Rapido.", image: "popular-5", urlToImage: URL(string: ""))])
    }()
    
    private let bestSeller: ListSection = {
        .bestSeller([.init(title: "Tokyo Ghoul", subtitle: "", image: "soon-1", urlToImage: URL(string: "")),
                     .init(title: "Record of Ragnarok", subtitle: "", image: "soon-2", urlToImage: URL(string: "")),
                     .init(title: "Kaisen Returns", subtitle: "", image: "soon-3", urlToImage: URL(string: "")),
                     .init(title: "No Idea", subtitle: "", image: "soon-4", urlToImage: URL(string: ""))])
    }()
    
    var pageData: [ListSection] {
        [category, hotSales, bestSeller]
    }
}
