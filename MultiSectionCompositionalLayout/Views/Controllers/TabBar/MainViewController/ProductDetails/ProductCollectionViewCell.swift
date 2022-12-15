//
//  ProductCollectionViewCell.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 11/12/2022.
//

import UIKit
import Gemini
import SDWebImage

class ProductCollectionViewCell: GeminiCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
  
    override func layoutSubviews() {
        
        // cell shadow section
        
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderWidth = 0.3
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
