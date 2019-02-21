//
//  UIViewControllerExtensions.swift
//  CollectionViewInsteadOfPagerView
//
//  Created by Zak Barlow on 21/02/2019.
//  Copyright © 2019 zakbarlow. All rights reserved.
//

import UIKit
import Foundation

//Navigation/status bar extensions
extension UIViewController {
    //https://stackoverflow.com/a/48684198/10623169
    
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */
    var topBarTotalHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    func setupTransparentNavigationBarWithBlackText() {
        setupTransparentNavigationBar()
        //Status bar text and back(item) tint to black
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func setupTransparentNavigationBarWithWhiteText() {
        setupTransparentNavigationBar()
        //Status bar text and back(item) tint to white
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setupTransparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
    }
}
