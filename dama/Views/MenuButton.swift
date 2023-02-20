//
//  MenuButton.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/20.
//

import UIKit

class MenuButton: DamaIconButton {

    override init(frame: CGRect) {
        super.init(frame: frame, image: UIImage(named: "menu")!)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
