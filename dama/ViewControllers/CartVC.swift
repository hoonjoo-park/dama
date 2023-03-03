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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
        
        configureSubViews()
        configureCartContainerUI()
        configureUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "장바구니"
        self.navigationController?.navigationBar.tintColor = DamaColors.black
        self.navigationController?.navigationBar.topItem?.title = ""
        view.backgroundColor = DamaColors.white
    }
    
    
    private func configureSubViews() {
        [cartContainer, bottomButton].forEach { view.addSubview($0) }
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
            cartContainer.heightAnchor.constraint(equalToConstant: 50),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bottomButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

}
