//
//  AlertConfirm.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/03/07.
//

import UIKit

class AlertConfirm {
    @objc func alertConfirmOrder() {
        let alert = UIAlertController(title: "주문하시겠습니까?", message: "금액과 메뉴를 꼭 확인해 주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
