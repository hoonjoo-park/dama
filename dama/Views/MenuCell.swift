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
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
