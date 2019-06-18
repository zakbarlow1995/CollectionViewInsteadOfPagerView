//
//  MainCell.swift
//  CollectionViewInsteadOfPagerView
//
//  Created by Zak Barlow on 18/06/2019.
//  Copyright © 2019 zakbarlow. All rights reserved.
//

import Foundation
import UIKit

class MainCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Custom UIColor extension to return a random colour (to check that everything is working)
        backgroundColor = UIColor().random()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
