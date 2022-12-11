//
//  ProductCollectionViewCell.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 11/12/2022.
//

import UIKit
import Gemini

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    func setUpWith(image: [String]?){
        if let images = image?.first{
            let url = URL(string: images)
            productImage.load(url: url!)
        }else if let images  = image?.last{
            let url = URL(string: images)
            productImage.load(url: url!)
        }
    }
}
