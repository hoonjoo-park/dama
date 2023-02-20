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
    let totalCountBodyLabel = DamaLabel(fontSize: 20, weight: UIFont.Weight.bold, color: DamaColors.black)
    let currentCountLabel = DamaLabel(fontSize: 20, weight: UIFont.Weight.bold, color: DamaColors.black)
    let currentCountBodyLabel = DamaLabel(fontSize: 20, weight: UIFont.Weight.bold, color: DamaColors.black)
    let bottomButton = DamaTextButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionVC()
        configureSubViews()
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
        [totalCountLabel, currentCountLabel, bottomButton].forEach { view.addSubview($0) }
        totalCountLabel.text = "담은 개수"
        currentCountLabel.text = "수량"
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
            
            currentCountLabel.topAnchor.constraint(equalTo: totalCountLabel.bottomAnchor, constant: 40),
            currentCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            currentCountLabel.widthAnchor.constraint(equalToConstant: 80),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bottomButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

