//
//  AddNewCardViewController.swift
//  YourCards
//
//  Created by Andrew on 11/5/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit

class AnimatedTabBarController: UITabBarController {
    
    var secondItemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let secondItemView = self.tabBar.subviews[1]
        self.secondItemImageView = secondItemView.subviews.first as! UIImageView
        self.secondItemImageView.contentMode = .center
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 1 {
            
            // MARK: - Do Our Animations
            
            self.secondItemImageView.transform = CGAffineTransform.identity
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations:{
                let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
                self.secondItemImageView.transform = rotation
                
                }, completion: nil)
            
        }
        
    }
    
    
    
}
