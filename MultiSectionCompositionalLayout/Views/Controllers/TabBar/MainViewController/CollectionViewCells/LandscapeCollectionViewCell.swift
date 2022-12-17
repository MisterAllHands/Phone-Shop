//
//  LandscapeCollectionViewCell.swift
//  MultiSectionCompositionalLayout
//
//  Created by Emmanuel Okwara on 15.05.22.
//

import UIKit
import SDWebImage


final class LandscapeCollectionViewCell: UICollectionViewCell {
    
    var models: Basket?
   
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var mainPrice: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var likedItem: UIButton!
    var isLiked = false
    
    
    func setup(item: BestSellerItem) {
        mainPrice.text = "$\(item.price_without_discount)"
        discountPrice.text = String(item.discount_price)
        itemName.text = item.title
        cellImageView.sd_setImage(with: URL(string: item.picture),
                                  placeholderImage: UIImage(named: "photo"),
                                  options: .continueInBackground,
                                  completed: nil)
        
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
    
        @IBAction func addedTofavorites(_ sender: UIButton) {
    
            isLiked = !isLiked
    
            if isLiked{
                likedItem.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    
               
    
                DatapersistantManager.shared.addItemToFavorites(model: models ?? Basket ) { result in
                        print("Downloaded")
                    }
    
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                    self.performTask(send: "addValue")
                }
            }
            else{
                likedItem.setImage(UIImage(systemName: "heart"), for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                    self.performTask(send: "removeValue")
                }
            }
        }
        
        func performTask(send: String) {
            
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name(send), object: nil)
            
        }
    
}
