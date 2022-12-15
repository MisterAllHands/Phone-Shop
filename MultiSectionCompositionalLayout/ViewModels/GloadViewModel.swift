//
//  GloabalModalView.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 11/12/2022.
//

import Foundation
import UIKit

enum CompositionalGroupAlighnment{
    case vertical
    case horizontal
}
//MARK: - CollectionView Customizations


struct Compositionallayout{
    
    static func createitem(with: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, spacing: CGFloat) -> NSCollectionLayoutItem{
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: with, heightDimension: height))
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing,
                                                     leading: spacing,
                                                     bottom: spacing,
                                                     trailing: spacing)
        return item
    }
    
    static func createGroup(alighment: CompositionalGroupAlighnment,
                            with: NSCollectionLayoutDimension,
                            height: NSCollectionLayoutDimension,
                            item: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
        switch alighment{
            
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                widthDimension: with,
                heightDimension: height),
                subitems: item)
            
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                widthDimension: with,
                heightDimension: height),
                subitems: item)
        }
    }
}

//MARK: - Customizing View

struct CustomizedView{
    
   static func setViewConstrainsts(with view: UIView) -> UIView{
        
        let dLayer = view.layer
        
        dLayer.masksToBounds = true
        dLayer.shadowColor = UIColor.black.cgColor
        dLayer.shadowOffset = CGSize(width: 0, height: 0)
        
        dLayer.shadowRadius = 10.0
        dLayer.shadowOpacity = 0.3
        dLayer.borderWidth = 0.1
        dLayer.borderColor = UIColor.flatGrayDark().cgColor
        dLayer.cornerRadius = 40
        dLayer.masksToBounds = false
        
        dLayer.shadowPath = UIBezierPath(roundedRect: view.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: dLayer.frame.width, height: 5)), cornerRadius: dLayer.cornerRadius).cgPath
       
       return view
    }
}

