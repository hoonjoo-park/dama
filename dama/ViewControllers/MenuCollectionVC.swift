//
//  MenuCollectionVC.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

private let reuseID = "MenuCell"

class MenuCollectionVC: UICollectionViewController {
    var allMenusVM: AllMenusViewModel!
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        fetchMenus()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureFlowLayout())
        self.collectionView!.register(MenuCell.self, forCellWithReuseIdentifier: reuseID)
    }
    
    func configureFlowLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 20
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (padding * 2)
        
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.4)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        return flowLayout
    }
    
    private func fetchMenus() {
        Task {
            do {
                let menus = try await WebService.shared.fetchMenus()

                allMenusVM = AllMenusViewModel(menus)
                collectionView.reloadData()
            }
            catch { throw ErrorMessages.InvalidData }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let allMenusVM = allMenusVM else { return 0}
        
        return allMenusVM.numberOfRowsInSection(section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as? MenuCell else {
            fatalError("MenuCell을 찾을 수 없습니다.")
        }
        
        allMenusVM.configureCell(indexPath.row, cell)
    
        return cell
    }
}
