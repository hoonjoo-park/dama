//
//  CollectionViewModel.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/26.
//

import Foundation

struct CollectionViewModel {
    var currentIndex: Observable<Int> = Observable(0)
    
    init(currentIndex: Int) {
        self.currentIndex = Observable(currentIndex)
    }
}
