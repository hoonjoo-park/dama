//
//  MenuButton.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/20.
//

import UIKit

class CartButton: DamaIconButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame, image: UIImage(named: "menu")!)
        
        configureUI()
        configureAction()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        layer.borderWidth = 1
        layer.borderColor = DamaColors.orange.cgColor
    }
    
    
    private func configureAction() {
        self.addTarget(self, action: #selector(onTappedMenuButton), for: .touchUpInside)
    }
    
    
    @objc func onTappedMenuButton() {
        let targetVC = CartVC()
        
        if let scene = UIApplication.shared.connectedScenes.first,
           let sceneDelegate = scene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            if let navigationController = window.rootViewController as? UINavigationController {
                navigationController.pushViewController(targetVC, animated: true)
            }
        }
    }
}
