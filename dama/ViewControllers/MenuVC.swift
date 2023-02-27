//
//  ViewController.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/11.
//

import UIKit

class MenuVC: UIViewController {
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
        configureBottomButton()
        configureUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "무엇을 주문하시겠어요?"
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let initialContentOffsetX: CGFloat = UIScreen.main.bounds.width - 25
        let fixedContentOffsetY = collectionView.contentOffset.y
        collectionView.setContentOffset(CGPoint(x: initialContentOffsetX, y: fixedContentOffsetY), animated: false)
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
        countView.totalCountLabel.text = "0"
        totalPriceLabel.text = "총 주문 금액"
        totalPriceValue.text = "원"
    }
    
    
    private func configureBottomButton() {
        bottomButton.addTarget(self, action: #selector(onTappedBottomButton), for: .touchUpInside)
    }
    
    
    @objc func onTappedBottomButton() {
        let alert = UIAlertController(title: "주문하시겠습니까?", message: "금액과 메뉴를 꼭 확인해 주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
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
}

