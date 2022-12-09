//
//  LandscapeCollectionViewCell.swift
//  MultiSectionCompositionalLayout
//
//  Created by Emmanuel Okwara on 15.05.22.
//

import UIKit

final class LandscapeCollectionViewCell: UICollectionViewCell {
    

    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var mainPrice: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    
    
    
    func setup(item: BestSellerItem) {
        mainPrice.text = "$\(item.price_without_discount)"
        discountPrice.text = String(item.discount_price)
        itemName.text = item.title
        
        if let imageData = item.picture{
            let url =  URL(string: imageData)
            cellImageView.load(url: url!)

        }
        
        //Setting linestrike for the label text
        
        let attributeString = NSMutableAttributedString(string: "$\(item.discount_price)")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
        
        //setting letter spacing
        
        attributeString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(1.0), range: NSRange(location: 0, length: attributeString.length))
        
        discountPrice.attributedText = attributeString
        
        //Setting letter spacing to the mainPriceLabel
        
        let attributedStrings = NSMutableAttributedString(string: mainPrice.text!)
        attributedStrings.addAttribute(NSAttributedString.Key.kern, value: CGFloat(1.0), range: NSRange(location: 0, length: attributedStrings.length))
        mainPrice.attributedText = attributedStrings

        
    }
}
