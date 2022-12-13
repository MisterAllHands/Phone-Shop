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
    
    func setup(item: HomeStore) {
        
        itemName.text = item.title
        itemSubtitle.text = item.subtitle        
    
            
        if let url = item.urlToImage{
            //fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.cellImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
        
        @IBAction func buyButtonPressed(_ sender: UIButton) {
            
            print("Bought!")
            
        }
}
