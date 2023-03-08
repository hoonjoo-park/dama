//
//  GradientVC.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/03/09.
//

import UIKit

class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            DamaColors.orange.cgColor,
            UIColor(r: 253, g: 160, b: 133).cgColor,
        ]
        
        layer.addSublayer(gradientLayer)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

