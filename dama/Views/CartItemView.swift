//
//  CartItemView.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/03/05.
//

import UIKit

class CartItemView: UIView {
    var cartItem: [String: Any]!
    let cartVM = CartViewModel.shared
    
    let itemTitle = DamaLabel(fontSize: 16, weight: .semibold, color: DamaColors.black)
    let itemPrice = DamaLabel(fontSize: 16, weight: .semibold, color: DamaColors.black)
    let countView = UIView(frame: .zero)
    let plusButton = DamaIconButton(frame: .zero, image: UIImage(systemName: "plus")!)
    let minusButton = DamaIconButton(frame: .zero, image: UIImage(systemName: "minus")!)
    let itemCount = DamaLabel(fontSize: 16, weight: .semibold, color: DamaColors.black)

    init(frame: CGRect, cartItem: [String: Any]) {
        super.init(frame: frame)
        
        self.cartItem = cartItem
        
        configureText()
        configureUI()
        configureCountViewUI()
        configureButtonActions()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureText() {
        guard let item = cartItem["item"] as? Menu, let count = cartItem["count"] as? Int else { return }
        
        itemTitle.text = "\(item.name)"
        itemPrice.text = "\(transPrice(item.price * count))원"
        itemCount.text = "\(count)"
    }
    
    
    private func configureUI() {
        [itemTitle, itemPrice, countView].forEach { addSubview($0) }
        countView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemTitle.topAnchor.constraint(equalTo: topAnchor),
            itemTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            itemPrice.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: 14),
            itemPrice.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemPrice.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            countView.trailingAnchor.constraint(equalTo: trailingAnchor),
            countView.centerYAnchor.constraint(equalTo: itemPrice.centerYAnchor),
            countView.widthAnchor.constraint(equalToConstant: 80),
            countView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
    private func configureCountViewUI() {
        [plusButton, itemCount, minusButton].forEach { countView.addSubview($0) }
        [plusButton, minusButton].forEach {
            $0.backgroundColor = DamaColors.orange
            $0.tintColor = DamaColors.black
            $0.layer.cornerRadius = 10
        }
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 53),
            
            plusButton.leadingAnchor.constraint(equalTo: countView.leadingAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 20),
            plusButton.heightAnchor.constraint(equalToConstant: 20),
            
            itemCount.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            itemCount.centerYAnchor.constraint(equalTo: countView.centerYAnchor),
            
            minusButton.trailingAnchor.constraint(equalTo: countView.trailingAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 20),
            minusButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
    private func configureButtonActions() {
        plusButton.addTarget(self, action: #selector(onPressPlusButton), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(onPressMinusButton), for: .touchUpInside)
    }
    
    
    @objc func onPressPlusButton() {
        print("Plus!")
    }
  
    
    @objc func onPressMinusButton() {
        print("Minus!")
    }
    
}
