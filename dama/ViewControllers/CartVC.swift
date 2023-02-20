//
//  CartVC.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/20.
//

import UIKit

class CartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "장바구니"
        self.navigationController?.navigationBar.tintColor = DamaColors.black
        self.navigationController?.navigationBar.topItem?.title = ""
        view.backgroundColor = DamaColors.white
    }

}
