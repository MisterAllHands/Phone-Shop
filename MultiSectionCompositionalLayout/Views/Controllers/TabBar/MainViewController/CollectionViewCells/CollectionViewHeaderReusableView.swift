
//  CollectionViewHeaderReusableView
//  MultiSectionCompositionalLayout

//  Created by TTGMOTSF on 9/12/22.


import UIKit

final class CollectionViewHeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var viewAll: UILabel!
    
    func setup( title: String,  secondTitle: String) {
        cellTitleLbl.text = title
        viewAll.text = secondTitle
    }
}
