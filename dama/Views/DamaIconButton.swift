//
//  DamaIconButton.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

class DamaIconButton: UIButton {
    let iconImage = UIImageView(frame: .zero)

    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        
        iconImage.image = image
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setImage(_ image: UIImage) {
        self.iconImage.image = image
    }

    
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        
        addSubview(iconImage)
        
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
}
