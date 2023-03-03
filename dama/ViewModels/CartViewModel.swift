//
//  CartViewModel.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/25.
//

import Foundation

class CartViewModel {
    static let shared = CartViewModel()
    
    var cart: Observable<[[String: Any]]> = Observable([[String: Any]]())
    var currentMenu: Observable<[String: Any]> = Observable([String: Any]())
    var currentIndex = 1
    var totalPrice: Observable<Int> = Observable(0)
    
    private init() {
        cart.value = [[String: Any]]()
        
        cart.subscribe { [weak self] menus in
            var currentPriceSum = 0
            menus.forEach { menu in
                guard let item = menu["item"] as? Menu, let count = menu["count"] as? Int else { return }
                currentPriceSum += item.price * count
            }
            
            self?.totalPrice.value = currentPriceSum
        }
    }
    
    
    func setCart(menus: [Menu]) {
        let cartItem = menus.map { menu in
            return ["item": menu, "count": 0]
        }
        
        cart.value = cartItem
        currentMenu.value = cartItem[1]
    }
    
    
    func setCurrentMenu(_ index:Int) {
        guard index > 0 || index < cart.value.count - 1 else { return }
        currentMenu.value = cart.value[index]
        currentIndex = index
    }
    
    
    func updateMenuCount(_ count: Int) {
        cart.value[currentIndex]["count"] = max(0, (cart.value[currentIndex]["count"] as? Int ?? 0) + count)
        currentMenu.value = cart.value[currentIndex]
    }
}
