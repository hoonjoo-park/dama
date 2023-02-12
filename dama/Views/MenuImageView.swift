//
//  MenuImageView.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

class MenuImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        
        configureImageView()
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
            await WebService.shared.downloadImage(imageUrl: url)
        }
    }
}
