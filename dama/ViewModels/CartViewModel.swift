//
//  CartViewModel.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/25.
//

import Foundation

class CartViewModel {
    var cart: [[String: Any]]!
    var currentMenu: [String: Any]!
    
    
    init(menus: [Menu]) {
        let cartItem = menus.map { menu in
            return ["item": menu, "count": 0]
        }
        
        self.cart = cartItem
    }
    
    func setCurrentMenu(_ index:Int) {
        self.currentMenu = self.cart[index]
    }
}
