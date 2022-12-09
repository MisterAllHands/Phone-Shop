//
//  PortraitCollectionViewCell.swift
//  MultiSectionCompositionalLayout
//
//  Created by Emmanuel Okwara on 15.05.22.
//

import UIKit

final class PortraitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSubtitle: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    func setup(item: HomeStoreItem) {
        
        itemName.text = item.title
        itemSubtitle.text = item.subtitle
        
        if let imageString = item.picture{
            let url = URL(string: imageString)
            cellImageView.load(url: url!)
        }
    }
        
        @IBAction func buyButtonPressed(_ sender: UIButton) {
            
            print("Bought!")
            
        }
}
