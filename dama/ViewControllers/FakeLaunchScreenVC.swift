//
//  FakeLaunchScreenVC.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/03/09.
//

import UIKit

class FakeLaunchScreenVC: UIViewController {
    let backgroundImage = UIImageView(image: UIImage(named: "background"))
    let logoImage = UIImageView(image: UIImage(named: "dama-logo"))
    let subTitle = DamaLabel(fontSize: 18, weight: .bold, color: DamaColors.white)
    let appTitle = DamaLabel(fontSize: 28, weight: .bold, color: DamaColors.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        startAnimation()
    }
    
    
    private func configureUI() {
        let logoWidth: CGFloat = 140
        [backgroundImage, logoImage, subTitle, appTitle].forEach {
            view.addSubview($0)
        }
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        subTitle.textAlignment = .center
        appTitle.textAlignment = .center
        subTitle.text = "먹고 싶은 거 맘껏"
        appTitle.text = "담아!"
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            logoImage.widthAnchor.constraint(equalToConstant: logoWidth),
            logoImage.heightAnchor.constraint(equalToConstant: logoWidth),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -logoWidth),
            
            subTitle.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30),
            subTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            appTitle.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 20),
            appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
    private func startAnimation() {
        logoImage.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: -140).isActive = true
        
        UIView.animate(withDuration: 0.7, delay: 0.2) {
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.05, delay: 0.3, animations: {
            self.subTitle.layer.opacity = 0
            self.appTitle.layer.opacity = 0
            self.view.backgroundColor = DamaColors.white
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.presentRealRootViewController()
                }
            }
        })
    }
    
    
    private func presentRealRootViewController() {
        let rootVC = MenuVC()
        let navVC = UINavigationController(rootViewController: rootVC)
        
        navVC.modalTransitionStyle = .crossDissolve
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
}
