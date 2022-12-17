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
    @IBOutlet weak var priceStepper: SwiftyStepper!
    
    var oldValue = 0.0
    var initialValue = 0
    
    
    func setUpWith(item: Baskets){
        
        itemLabel.text = item.title
        itemPrice.text = "\(item.price)"
        let urlstring = URL(string: item.images ?? "")
        
        itemImage.sd_setImage(with: urlstring )
        itemImage.layer.cornerRadius = 20
        
        oldValue = priceStepper.value
        
        if let converted = Int(itemPrice.text!){
            initialValue = converted
        }
        
        
    }
    
    @IBAction func stepper(_ sender: SwiftyStepper) {
        
        //Incrementing if sender's value is increasing
        
        if sender.value > oldValue{
            
            if let intConverted = Float(itemPrice.text!){
                oldValue = oldValue + 1
                itemPrice.text = String(format: "%.2f", intConverted + Float(initialValue))
            }
            self.performTask(send: "updateView")

        }else{
            
            //Decrimenting if sender's value is decreasing 
            
            oldValue = oldValue - 1
            
            if let intConverted = Float(itemPrice.text!){
                
                itemPrice.text = String(format: "%.2f", Float(intConverted) - Float(initialValue))
                
            }
       
            self.performTask(send: "updateView")
            
        }
    }
    
    func performTask(send: String) {
        
        let itemPriceDict: [String : String] = ["itemPrice": itemPrice.text ?? "nil"]
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name(send), object: nil, userInfo: itemPriceDict)
        
    }
}
