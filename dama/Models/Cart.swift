//
//  Cart.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/26.
//

import Foundation

class Cart {
    var cart: [[String: Any]]
    
    init(menus: [Menu]) {
        let cartItem = menus.map { menu in
            return ["item": menu, "count": 0]
        }
        
        self.cart = cartItem
    }
    
    func currentMenu(_ index: Int) -> [String: Any] {
        return self.cart[index]
    }
}
