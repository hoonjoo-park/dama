//
//  MenuImageView.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

class MenuImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImageView() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        self.layer.cornerRadius = 12
    }
    
    func downloadImage(url: String) {
        Task {
            image = await WebService.shared.downloadImage(imageUrl: url)
        }
    }
}
