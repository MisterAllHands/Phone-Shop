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
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with image: String, title: String) {
        cellImageView.image = UIImage(named: image)
        phoneTitle.text = title
        cellImageView.layer.cornerRadius = cellImageView.frame.height / 2
        cellImageView.layer.masksToBounds = false
    }
    
    func showImage(){
        cellImageView.alpha = 1.0
    }
    func hideImage(){
        cellImageView.alpha = 0.0
    }
}
