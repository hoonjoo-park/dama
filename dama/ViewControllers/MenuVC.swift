//
//  ViewController.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/11.
//

import UIKit

class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMenus()
    }
    
    private func fetchMenus() {
        Task {
            do {
                let menus = try await WebService.shared.fetchMenus()
                
                print(menus)
            }
            catch { throw ErrorMessages.InvalidData }
        }
    }


}

