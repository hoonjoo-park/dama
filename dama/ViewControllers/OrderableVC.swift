//
//  OrderableVC.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/03/07.
//

import UIKit

class OrderableViewController: UIViewController {
    let cartVM = CartViewModel.shared
    
    @objc func showConfirmOrder() {
        let cart = cartVM.cart.value.filter { cartItem in
            guard let count = cartItem["count"] as? Int else { return false }
            return count > 0
        }
        
        if cart.isEmpty {
            showEmptyCartAlert()
            return
        }
        
        
        let targetVC = OrderResultVC()
        let alert = UIAlertController(title: "주문하시겠습니까?", message: "금액과 메뉴를 꼭 확인해 주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.navigationController?.pushViewController(targetVC, animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    private func showEmptyCartAlert() {
        let confirm = UIAlertController(title: "장바구니가 비어있습니다", message: "메뉴를 담은 뒤 주문을 진행해 주세요", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .cancel)
        
        confirm.addAction(confirmAction)
        present(confirm, animated: true, completion: nil)
    }

}
