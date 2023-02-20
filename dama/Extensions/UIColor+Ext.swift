//
//  UIColor+Ext.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/20.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
