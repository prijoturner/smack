//
//  CircleImage.swift
//  Smack
//
//  Created by Prijo on 30/09/18.
//  Copyright © 2018 Prijo Turner. All rights reserved.
//

import UIKit

@IBDesignable

class CircleImage: UIImageView {
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

}
