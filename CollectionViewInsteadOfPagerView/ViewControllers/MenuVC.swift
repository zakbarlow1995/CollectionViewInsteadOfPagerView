//
//  MenuVC.swift
//  CollectionViewInsteadOfPagerView
//
//  Created by Zak Barlow on 18/06/2019.
//  Copyright © 2019 zakbarlow. All rights reserved.
//

import Foundation
import UIKit

protocol MenuVCDelegate {
    func didTapMenuItem(indexPath: IndexPath)
}

class MenuVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate let menuItems = ["A", "B", "C"]
    
    var delegate: MenuVCDelegate?
    
    //Sliding bar indicator (slightly different from original question - like Reddit)
    let menuBar: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    //1px view to visually separate MenuBar region from "pager"-views
    let menuSeparator: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = true
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        view.addSubview(menuSeparator)
        menuSeparator.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: 1))
        
        view.addSubview(menuBar)
        menuBar.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, size: .init(width: 0, height: 2))
        menuBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/(CGFloat(menuItems.count))).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapMenuItem(indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.label.text = menuItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return .init(width: width/CGFloat(menuItems.count), height: view.frame.height)
    }
    
}
