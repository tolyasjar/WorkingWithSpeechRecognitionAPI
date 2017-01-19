//
//  CircleButton.swift
//  WorkingWithSpeechRecognitionAPI
//
//  Created by Toleen Jaradat on 1/10/17.
//  Copyright © 2017 Toleen Jaradat. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
        
    }
    

}
