//
//  ViewController.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/11.
//

import UIKit

class MenuVC: OrderableViewController {
    let padding:CGFloat = 25
    
    var collectionView: UICollectionView!
    
    let totalCountLabel = DamaLabel(fontSize: 20, weight: UIFont.Weight.bold, color: DamaColors.black)
    let countView = CountView(frame: .zero)
    let totalPriceLabel = DamaLabel(fontSize: 20, weight: UIFont.Weight.bold, color: DamaColors.black)
    let totalPriceValue = DamaLabel(fontSize: 20, weight: UIFont.Weight.bold, color: DamaColors.black)
    let cartButton = CartButton(frame: .zero)
    let bottomButton = DamaTextButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionVC()
        configureSubViews()
        configureButtonsTarget()
        configureUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "무엇을 주문하시겠어요?"
        configureSubscribe()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let initialContentOffsetX: CGFloat = UIScreen.main.bounds.width - 25
        let fixedContentOffsetY = collectionView.contentOffset.y
        
        collectionView.setContentOffset(CGPoint(x: initialContentOffsetX * CGFloat(cartVM.currentIndex.value), y: fixedContentOffsetY), animated: false)
    }
    
    
    private func configureCollectionVC() {
        let collectionVC = MenuCollectionVC(collectionViewLayout: UICollectionViewLayout())
        
        addChild(collectionVC)
        view.addSubview(collectionVC.collectionView)
        collectionVC.didMove(toParent: self)
        collectionView = collectionVC.collectionView
    }
    
    
    private func configureSubViews() {
        [totalCountLabel, countView, totalPriceLabel, totalPriceValue, cartButton, bottomButton].forEach { view.addSubview($0) }
        bottomButton.setText("주문하기")
        totalCountLabel.text = "담은 개수"
        countView.countLabel.text = "0"
        totalPriceLabel.text = "총 주문 금액"
    }
    
    
    private func configureButtonsTarget() {
        bottomButton.addTarget(self, action: #selector(showConfirmOrder), for: .touchUpInside)
    }
    
    
    private func configureUI() {
        let cellHeight = (UIScreen.main.bounds.width - (padding * 2)) * 1.3
        
        view.backgroundColor = DamaColors.white
        bottomButton.backgroundColor = DamaColors.orange
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: cellHeight),
            
            totalCountLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            totalCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            totalCountLabel.widthAnchor.constraint(equalToConstant: 80),
            
            countView.centerYAnchor.constraint(equalTo: totalCountLabel.centerYAnchor),
            countView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            countView.widthAnchor.constraint(equalToConstant: 167),
            countView.heightAnchor.constraint(equalToConstant: 50),
            
            totalPriceLabel.topAnchor.constraint(equalTo: totalCountLabel.bottomAnchor, constant: 40),
            totalPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            totalPriceLabel.widthAnchor.constraint(equalToConstant: 140),
            
            totalPriceValue.centerYAnchor.constraint(equalTo: totalPriceLabel.centerYAnchor),
            totalPriceValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            cartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cartButton.widthAnchor.constraint(equalToConstant: 60),
            cartButton.heightAnchor.constraint(equalToConstant: 60),
            cartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomButton.leadingAnchor.constraint(equalTo: cartButton.trailingAnchor, constant: 10),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bottomButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    
    private func configureSubscribe() {
        cartVM.cart.subscribe { [weak self] cart in
            guard let totalPrice = self?.cartVM.calcTotalPrice() else { return }
            self?.cartVM.totalPrice.value = totalPrice
            
            guard let cart = self?.cartVM.cart.value,
                  let currentIndex = self?.cartVM.currentIndex.value,
                  !cart.isEmpty else { return }
            
            guard let count = cart[currentIndex]["count"] as? Int else { return }
            
            self?.countView.countLabel.text = "\(count)"
            
            let cartCount = cart.dropFirst().dropLast().filter { item in
                guard let itemCount = item["count"] as? Int else { return false }
                return itemCount > 0
            }.count
            
            if cartCount == 0 {
                self?.cartButton.countBadge.alpha = 0
            } else {
                self?.cartButton.countBadge.alpha = 1
                self?.cartButton.countBadge.text = "\(cartCount)"
            }
        }
        
        cartVM.currentIndex.subscribe { [weak self] currentIndex in
            guard let cart = self?.cartVM.cart.value,
                  !cart.isEmpty else { return }
            
            guard let count = cart[currentIndex]["count"] as? Int else { return }

            
            self?.countView.countLabel.text = "\(count)"
        }
        
        cartVM.totalPrice.subscribe { [weak self] price in
            self?.totalPriceValue.text = "\(transPrice(price)) 원"
        }
    }
}
