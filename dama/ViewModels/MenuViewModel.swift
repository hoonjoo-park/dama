//
//  MenuViewModel.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import Foundation

struct MenuViewModel {
    var menu: Observable<Menu>
    
    init(menu: Observable<Menu>) {
        self.menu = menu
    }
}
