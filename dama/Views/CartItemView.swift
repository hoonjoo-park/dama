//
//  CartItemView.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/03/05.
//

import UIKit

class CartItemView: UIView {
    var cartItem: [String: Any]!
    
    let itemTitle = DamaLabel(fontSize: 16, weight: .semibold, color: DamaColors.black)
    let itemPrice = DamaLabel(fontSize: 16, weight: .semibold, color: DamaColors.black)
    let plusButton = DamaIconButton(frame: .zero, image: UIImage(systemName: "plus")!)
    let minusButton = DamaIconButton(frame: .zero, image: UIImage(systemName: "minus")!)
    let itemCount = DamaLabel(fontSize: 16, weight: .semibold, color: DamaColors.black)

    init(frame: CGRect, cartItem: [String: Any]) {
        super.init(frame: frame)
        
        self.cartItem = cartItem
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
