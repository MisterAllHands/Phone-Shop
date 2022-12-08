//
//  StoryCollectionViewCell.swift
//  MultiSectionCompositionalLayout
//
//  Created by Emmanuel Okwara on 15.05.22.
//

import UIKit

final class StoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var phoneTitle: UILabel!
    
    func setup(with image: String, title: String) {
        cellImageView.image = UIImage(named: image)
        phoneTitle.text = title
        cellImageView.layoutIfNeeded()
        cellImageView.layer.cornerRadius = cellImageView.frame.height / 2
        cellImageView.layer.masksToBounds = false
        
    }
}
