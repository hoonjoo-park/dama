//
//  MenuImageView.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

class MenuImageView: UIImageView {
    let defaultImage = UIImage(named: "place-holder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImageView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureImageView() {
        contentMode = .scaleAspectFill
        image = defaultImage
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    
    func downloadImage(url: String) {
        Task {
            image = await WebService.shared.downloadImage(imageUrl: url)
        }
    }
}
