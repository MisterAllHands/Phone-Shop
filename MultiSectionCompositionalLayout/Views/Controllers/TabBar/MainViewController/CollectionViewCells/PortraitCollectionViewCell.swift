//
//  PortraitCollectionViewCell.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 7/12/22.
//

import UIKit
import SDWebImage


final class PortraitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSubtitle: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    func setup(item: HomeStoreItem) {
        
        itemName.text = item.title
        itemSubtitle.text = item.subtitle
        cellImageView.sd_setImage(with: URL(string: item.picture),
                                  placeholderImage: UIImage(named: "photo"),
                                  options: .continueInBackground,
                                  completed: nil)

    }
        
        @IBAction func buyButtonPressed(_ sender: UIButton) {
            
            print("Bought!")
            
        }
}
