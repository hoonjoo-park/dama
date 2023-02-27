//
//  CartViewModel.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/25.
//

import Foundation

class CartViewModel {
    static let shared = CartViewModel()
    
    var cart = [[String: Any]]()
    var currentMenu = [String: Any]()
    
    private init() {
        cart = [[String: Any]]()
        currentMenu = [String: Any]()
    }
    
    
    func setCart(menus: [Menu]) {
        let cartItem = menus.map { menu in
            return ["item": menu, "count": 0]
        }
        
        self.cart = cartItem
        self.currentMenu = cartItem[1]
    }
    
    
    func setCurrentMenu(_ index:Int) {
        self.currentMenu = self.cart[index]
    }
}
