//
//  CustomButton.swift
//  OnTrack
//
//  Created by Richard Price on 17/09/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class CustomButton: UIButton {
    let size: CGSize = CGSize(width: 0.95, height: 0.95)
    let size1: CGSize = CGSize(width: 3.0, height: 3.0)
    let size2: CGSize = CGSize(width: 1.0, height: 1.0)
    
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        
        didSet {
            
            setupView()
            
        }
        
    }
    
    @IBInspectable var fontColor: UIColor = UIColor.white {
        
        didSet {
            
            self.tintColor = fontColor
            
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        
        setupView()
        
    }
    
    func setupView() {
        
        self.layer.cornerRadius = cornerRadius
        
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), for: .touchDown)
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), for: .touchDragEnter)
        self.addTarget(self, action: #selector(CustomButton.scaleAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), for: .touchDragExit)
    }
    
    /////ANIMATIONS/////
    
    @objc func scaleToSmall() {
        
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = size
        self.layer.pop_add(scaleAnim, forKey: "layerScaleSmallAnimation")
        
    }
    
    @objc func scaleAnimation() {
        
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = size1
        scaleAnim?.toValue = size2
        scaleAnim?.springBounciness = 20
        self.layer.pop_add(scaleAnim, forKey: "layerScaleSpringAnimation")
    }
    
    @objc func scaleDefault() {
        
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = size
        self.layer.pop_add(scaleAnim, forKey: "layerScapeDefaultAnimation")
        
    }
    
}
