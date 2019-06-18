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
    
    let label: UILabel = {
        let l = UILabel()
        l.text = ""
        l.textAlignment = .center
        l.textColor = .white
        l.numberOfLines = 1
        l.adjustsFontSizeToFitWidth = true
        l.font = UIFont.systemFont(ofSize: 100, weight: .bold )
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor().random()
        addSubview(label)
        label.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func configureTitle(_ title: String) {
        label.text = title
    }
}
