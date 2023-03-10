//
//  MenuButton.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/20.
//

import UIKit

protocol CartButtonDelegate: AnyObject {
    func pushCartVC()
}

class CartButton: DamaIconButton {
    weak var delegate: CartButtonDelegate?
    
    let countBadge = DamaLabel(fontSize: 10, weight: .medium, color: DamaColors.black)
    let borderView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame, image: UIImage(named: "menu")!)
        
        configureBorderViewUI()
        configureCountBadgeUI()
        configureUI()
        configureAction()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureBorderViewUI() {
        borderView.frame = bounds
        borderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        borderView.layer.cornerRadius = 12
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = DamaColors.orange.cgColor
        borderView.isUserInteractionEnabled = false
    }
    
    
    private func configureCountBadgeUI() {
        countBadge.alpha = 0
        countBadge.layer.cornerRadius = 10
        countBadge.clipsToBounds = true
        countBadge.backgroundColor = DamaColors.orange
        countBadge.textAlignment = .center
    }
    
    
    private func configureUI() {
        [borderView, countBadge].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            countBadge.widthAnchor.constraint(equalToConstant: 20),
            countBadge.heightAnchor.constraint(equalToConstant: 20),
            countBadge.topAnchor.constraint(equalTo: topAnchor, constant: -5),
            countBadge.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
        ])
    }
    
    
    private func configureAction() {
        self.addTarget(self, action: #selector(onTappedMenuButton), for: .touchUpInside)
    }
    
    
    @objc func onTappedMenuButton() {
        delegate?.pushCartVC()
    }
}
