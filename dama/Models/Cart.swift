//
//  Cart.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/25.
//

import Foundation

class CartItem {
    var item: Menu
    var count: Int = 0
    
    init(item: Menu) {
        self.item = item
    }
}


