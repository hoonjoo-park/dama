//
//  CartVC.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/20.
//

import UIKit

class CartVC: UIViewController {
    let cartVM = CartViewModel.shared
    
    let bottomButton = DamaTextButton(frame: .zero)
    let cartContainer = UIView(frame: .zero)
    let cartStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
        
        configureSubViews()
        configureCartContainerUI()
        configureUI()
        configureStackSubViews()
        configureStackView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureSubscribe()
        
        title = "장바구니"
        self.navigationController?.navigationBar.tintColor = DamaColors.black
        self.navigationController?.navigationBar.topItem?.title = ""
        view.backgroundColor = DamaColors.white
    }
    
    
    private func configureSubscribe() {
        cartVM.totalPrice.subscribe { [weak self] price in
            self?.bottomButton.setText("\(transPrice(price))원 주문하기")
        }
    }
    
    
    private func configureSubViews() {
        [cartContainer, bottomButton].forEach { view.addSubview($0) }
        cartContainer.addSubview(cartStackView)
    }
    
    
    private func configureCartContainerUI() {
        cartContainer.translatesAutoresizingMaskIntoConstraints = false
        
        cartContainer.layer.cornerRadius = 15
        cartContainer.layer.shadowColor = DamaColors.black.cgColor
        cartContainer.layer.shadowOpacity = 0.25
        cartContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        cartContainer.layer.shadowRadius = 2
        cartContainer.backgroundColor = DamaColors.lightGray
        cartContainer.layer.masksToBounds = false
        
    }
    
    
    private func configureUI() {
        let padding:CGFloat = 25
        
        bottomButton.backgroundColor = DamaColors.orange
        
        NSLayoutConstraint.activate([
            cartContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            cartContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cartContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bottomButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    
    private func configureStackSubViews() {
        let cartMenus = cartVM.cart.value.dropFirst().dropLast().filter { cartMenu in
            guard let count = cartMenu["count"] as? Int else { return false }
            return count > 0
        }
        
        if cartMenus.count == 0 {
            let emptyLabel = DamaLabel(fontSize: 14, weight: .medium, color: DamaColors.black)
            emptyLabel.text = "담은 상품이 아직 없어요...🥺"
            cartStackView.addArrangedSubview(emptyLabel)
            return
        }
        
        cartMenus.forEach { cartMenu in
            let cartItemView = CartItemView(frame: .zero, cartItem: cartMenu)
            
            cartStackView.addArrangedSubview(cartItemView)
        }
    }
    
    
    private func configureStackView() {
        cartStackView.translatesAutoresizingMaskIntoConstraints = false
        cartStackView.axis = .vertical
        cartStackView.alignment = .fill
        cartStackView.distribution = .fillEqually
        cartStackView.spacing = 40
        
        NSLayoutConstraint.activate([            
            cartStackView.topAnchor.constraint(equalTo: cartContainer.topAnchor, constant: 35),
            cartStackView.leadingAnchor.constraint(equalTo: cartContainer.leadingAnchor, constant: 20),
            cartStackView.trailingAnchor.constraint(equalTo: cartContainer.trailingAnchor, constant: -20),
            cartStackView.bottomAnchor.constraint(equalTo: cartContainer.bottomAnchor, constant: -35),
        ])
    }
}
