//
//  OrderResultVC.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

class OrderResultVC: UIViewController {
    let cartVM = CartViewModel.shared
    let boxImage = UIImageView(image: UIImage(named: "order-box"))
    let boldTextLabel = DamaLabel(fontSize: 18, weight: .bold, color: DamaColors.black)
    let regularTextLabel = DamaLabel(fontSize: 14, weight: .medium, color: DamaColors.gray)
    let bottomButton = DamaTextButton(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBottomAction()
        configureUI()
        handleData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
        view.backgroundColor = DamaColors.white
    }
    
    
    private func configureNavigation() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissViewController))
        closeButton.tintColor = DamaColors.black
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.setRightBarButton(closeButton, animated: true)
    }
    
    
    @objc func dismissViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func handleData() {
        regularTextLabel.text = "총 주문 금액: \(transPrice(cartVM.totalPrice.value))원"
        
        cartVM.resetCart()
    }
    
    
    private func configureBottomAction() {
        bottomButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }
    
    
    private func configureUI() {
        let padding:CGFloat = 25
        
        [boxImage, boldTextLabel, regularTextLabel, bottomButton].forEach { [weak self] subView in
            self?.view.addSubview(subView)
        }
        
        boxImage.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.backgroundColor = DamaColors.orange
        boldTextLabel.text = "주문이 완료되었습니다!"
        bottomButton.setText("처음으로")
        
        NSLayoutConstraint.activate([
            boxImage.widthAnchor.constraint(equalToConstant: 150),
            boxImage.heightAnchor.constraint(equalToConstant: 150),
            boxImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 190),
            boxImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            boldTextLabel.topAnchor.constraint(equalTo: boxImage.bottomAnchor, constant: 54),
            boldTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            regularTextLabel.topAnchor.constraint(equalTo: boldTextLabel.bottomAnchor, constant: 20),
            regularTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bottomButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
}
