//
//  RoundBottons.swift
//  Calculator
//
//  Created by Andrew on 10/10/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 3 : 1
    }
    
}


