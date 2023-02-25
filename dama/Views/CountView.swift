//
//  CountView.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/22.
//

import UIKit

class CountView: UIView {
    let plusButton = DamaIconButton(frame: .zero, image: UIImage(systemName: "plus")!)
    let totalCountValue = DamaLabel(fontSize: 20, weight: UIFont.Weight.bold, color: DamaColors.black)
    let minusButton = DamaIconButton(frame: .zero, image: UIImage(systemName: "minus")!)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = DamaColors.gray.cgColor
        layer.cornerRadius = 12
        
        [plusButton, minusButton].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            plusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            
            minusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 30),
            minusButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
}
