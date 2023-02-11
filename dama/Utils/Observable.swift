//
//  Observable.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            self.listener?(value)
        }
    }
    
    var listener: ((T) -> Void)?
    
    init(_ value: T) { self.value = value }
    
    func subscribe(listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
