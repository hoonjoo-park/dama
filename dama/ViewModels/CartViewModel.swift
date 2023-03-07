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
    var currentIndex = Observable(1)
    var totalPrice: Observable<Int> = Observable(0)
    
    private init() {
        cart.value = [[String: Any]]()
        
        cart.subscribe { [weak self] _ in
            guard let totalPrice = self?.calcTotalPrice() else { return }
            
            self?.totalPrice.value = totalPrice
        }
    }
    
    
    func setCart(menus: [Menu]) {
        let cartItem = menus.map { menu in
            return ["item": menu, "count": 0]
        }
        
        cart.value = cartItem
    }
    
    
    func setCurrentIndex(_ index:Int) {
        guard index > 0 || index < cart.value.count - 1 else { return }
        currentIndex.value = index
    }
    
    
    func getCartItemIndexById(_ id: Int) -> Int? {
        let index = cart.value.firstIndex(where: {
            guard let item = $0["item"] as? Menu else { return false }
            return item.id == id
        })
        
        return index
    }
    
    
    func getCartItemById(_ id: Int) -> [String: Any]? {
        guard let targetIndex = getCartItemIndexById(id) else { return nil }
        
        return cart.value[targetIndex]
    }
    
    
    func updateCurrentMenuCount(_ count: Int) {
        cart.value[currentIndex.value]["count"] = max(0, (cart.value[currentIndex.value]["count"] as? Int ?? 0) + count)
    }
    
    
    func updateMenuCount(_ id: Int, _ count: Int) {
        if let targetIndex = getCartItemIndexById(id) {
            cart.value[targetIndex]["count"] = max(0, (cart.value[targetIndex]["count"] as? Int ?? 0) + count)
        }
    }
    
    
    func calcTotalPrice() -> Int {
        var currentPriceSum = 0
        
        cart.value.forEach { menu in
            guard let item = menu["item"] as? Menu, let count = menu["count"] as? Int else { return }
            currentPriceSum += item.price * count
        }
        
        return currentPriceSum
    }
    
    
    func resetCart() {
        for i in 0..<cart.value.count { cart.value[i]["count"] = 0 }
        
        currentIndex.value = 1
        totalPrice.value = 0
    }
}
