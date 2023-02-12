//
//  MenuCell.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

class MenuCell: UICollectionViewCell {
    let menuTitle = DamaLabel(fontSize: 24, weight: .bold, color: .white)
    let menuPrice = DamaLabel(fontSize: 18, weight: .bold, color: .white)
    let menuImage = MenuImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        let padding: CGFloat = 20
        
        let overlay = UIView(frame: self.bounds)
        overlay.backgroundColor = .black.withAlphaComponent(0.3)
        
        
        addSubview(menuImage)
        [overlay, menuTitle, menuPrice].forEach { menuImage.addSubview($0) }
        
        menuImage.frame = self.bounds
        
        NSLayoutConstraint.activate([
            menuTitle.leadingAnchor.constraint(equalTo: menuImage.leadingAnchor, constant: padding),
            menuTitle.trailingAnchor.constraint(equalTo: menuImage.trailingAnchor, constant: -padding),
            menuTitle.bottomAnchor.constraint(equalTo: menuImage.bottomAnchor, constant: -75),

            menuPrice.topAnchor.constraint(equalTo: menuTitle.bottomAnchor, constant: 18),
            menuPrice.leadingAnchor.constraint(equalTo: menuTitle.leadingAnchor),
            menuPrice.trailingAnchor.constraint(equalTo: menuTitle.trailingAnchor),
        ])
    }
}
