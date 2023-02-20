//
//  DamaLabel.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

class DamaLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat, weight: UIFont.Weight?, color: UIColor?) {
        self.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight ?? .regular)
        self.textColor = color ?? DamaColors.black
        
        configureLabel()
    }
    
    func configureLabel() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
