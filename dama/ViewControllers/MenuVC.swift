//
//  ViewController.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/11.
//

import UIKit

class MenuVC: UIViewController {
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionVC()
        configureUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "무엇을 주문하시겠어요?"
    }
    
    
    private func configureCollectionVC() {
        let collectionVC = MenuCollectionVC(collectionViewLayout: UICollectionViewLayout())
        
        addChild(collectionVC)
        view.addSubview(collectionVC.collectionView)
        collectionVC.didMove(toParent: self)
        collectionView = collectionVC.collectionView
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
    }
}

