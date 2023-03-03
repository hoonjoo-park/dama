//
//  Public.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/03/03.
//

import Foundation

func transPrice(_ price: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    
    return formatter.string(from: NSNumber(value: price)) ?? ""
}
