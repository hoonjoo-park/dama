//
//  DamaTextButton.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

class DamaTextButton: UIButton {
    var buttonLabel = DamaLabel(fontSize: 20, weight: .bold, color: DamaColors.white)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setText(_ text: String) {
        self.buttonLabel.text = text
    }
    
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        
        addSubview(buttonLabel)
        
        NSLayoutConstraint.activate([
            buttonLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }

}
