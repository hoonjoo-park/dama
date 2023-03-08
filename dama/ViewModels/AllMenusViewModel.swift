//
//  MenuVM.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

struct AllMenusViewModel {
    let menus: Observable<[Menu]>
    
    init(_ menus: [Menu]) { self.menus = Observable(menus) }
    
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.menus.value.count
    }
    
    
    func configureCell(_ index: Int, _ cell: MenuCell) {
        let menu = menus.value[index]
        let menuVM = MenuViewModel(Observable(menu))
        
        menuVM.menu.subscribe {
            cell.menuImage.downloadImage(url: $0.imageUrl)
            cell.menuTitle.text = $0.name
            cell.menuPrice.text = "\(transPrice($0.price))원"
        }
    }
}
