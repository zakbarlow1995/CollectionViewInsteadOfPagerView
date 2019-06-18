//
//  MainVC.swift
//  CollectionViewInsteadOfPagerView
//
//  Created by Zak Barlow on 18/06/2019.
//  Copyright © 2019 zakbarlow. All rights reserved.
//

import Foundation
import UIKit

class MainVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let menuController = MenuVC(collectionViewLayout: UICollectionViewFlowLayout())
    fileprivate let cellId = "cellId"
    
    fileprivate let pages = ["aVC", "bVC", "cVC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "CollectionView \"Pager\" Demo"
        
        view.backgroundColor = .white
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        menuController.delegate = self
        menuController.collectionView.selectItem(at: [0, 0], animated: true, scrollPosition: .centeredHorizontally)
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        guard let menuView = menuController.view else { return }
        
        view.addSubview(menuView)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        menuView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: self.topBarTotalHeight, left: 0, bottom: 0, right: 0) , size: .init(width: view.bounds.width, height: 30))
        collectionView.anchor(top: menuView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: cellId)
        
        //Make the collection view behave like a pager view (no overscroll, paging enabled)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.allowsSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        setupTransparentNavigationBarWithBlackText()
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let offset = x / CGFloat(pages.count)
        menuController.menuBar.transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let item = Int(scrollView.contentOffset.x / view.frame.width)
        let indexPath = IndexPath(item: item, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let item = Int(x / view.frame.width)
        let indexPath = IndexPath(item: item, section: 0)
        menuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: collectionView.bounds.height)
    }
    
}

extension MainVC: MenuVCDelegate {
    
    // Delegate method implementation (scroll to the right page when the corresponding Menu "Button"(Item) is pressed
    func didTapMenuItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
