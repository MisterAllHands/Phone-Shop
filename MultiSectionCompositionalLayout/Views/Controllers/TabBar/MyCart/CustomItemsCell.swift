//
//  CustomItemsCell.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 15/12/2022.
//

import UIKit
import SwiftyStepper
import SDWebImage



class CustomItemsCell: UITableViewCell {
    
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func setUpWith(item: CartItem){
        
        itemLabel.text = item.title
        itemPrice.text = String(item.total)
        itemImage.sd_setImage(with: item.images)
        
    }
    
    @IBAction func stepper(_ sender: SwiftyStepper) {
        print(sender.value)
    }
    
}
