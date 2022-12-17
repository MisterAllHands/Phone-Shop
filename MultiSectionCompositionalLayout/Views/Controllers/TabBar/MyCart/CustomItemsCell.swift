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
    
    
    @IBOutlet weak var deleteItem: UIButton!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var priceStepper: SwiftyStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUpWith(item: Basket){
        
        itemLabel.text = "\(item.title)"
        itemPrice.text = "\(item.price)"
        let urlstring = URL(string: item.images)
        
        itemImage.sd_setImage(with: urlstring )
        itemImage.layer.cornerRadius = 20
        
    }

    @IBAction func stepper(_ sender: SwiftyStepper) {
            
            let intConverted = Double(itemPrice.text!)
            print(intConverted)
            itemPrice.text = String(sender.value * (intConverted ?? 1))
        
            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                self.performTask(send: "updateView")
            }
    }
    
    func performTask(send: String) {
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name(send), object: nil)
        
    }
    
}
