//
//  CartViewModel.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/25.
//

import Foundation

struct CartViewModel {
    var cart: [[String: Any]]
    
    init(menus: [Menu]) {
        let cartItem = menus.map { menu in
            return ["item": menu, "count": 0]
        }
        
        self.cart = cartItem
    }
}
