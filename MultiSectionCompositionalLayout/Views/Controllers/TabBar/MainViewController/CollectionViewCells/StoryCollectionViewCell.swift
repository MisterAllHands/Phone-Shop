//
//  StoryCollectionViewCell.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 15/12/22.
//

import UIKit

final class StoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var phoneTitle: UILabel!
    
    func setup(with image: String, title: String) {
        cellImageView.image = UIImage(named: image)
        phoneTitle.text = title
        cellImageView.layer.cornerRadius = cellImageView.frame.height / 2
        cellImageView.layer.masksToBounds = false
    }
}
