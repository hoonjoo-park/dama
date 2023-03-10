//
//  Menu.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import Foundation

struct Menus: Codable {
    let menus: [Menu]
}

struct Menu: Codable {
    let id: Int
    let name: String
    let price: Int
    let imageUrl: String
}
