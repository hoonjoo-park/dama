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
    var currentIndex = 0
    var startX: CGFloat!
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
        fetchMenus()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        configureCollectionView()
    }
    
    
    func configureCollectionView() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureFlowLayout())
        collectionView.addGestureRecognizer(panGesture)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        collectionView!.register(MenuCell.self, forCellWithReuseIdentifier: reuseID)
    }
    
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let offsetY = collectionView.contentOffset.y
        let threshold:CGFloat = 60
        
        switch gesture.state {
        case .began:
            startX = collectionView.contentOffset.x
        case .changed:
            let translationX = gesture.translation(in: collectionView).x
            collectionView.setContentOffset(CGPoint(x: startX - translationX, y: offsetY), animated: false)
        case .ended:
            let lastX = gesture.translation(in: collectionView).x
            let movedX = abs(startX - lastX)
            
            if (movedX < threshold) {
                collectionView.setContentOffset(CGPoint(x: startX, y: offsetY), animated: true)
            } else {
                collectionView.setContentOffset(CGPoint(x: calculateTargetOffsetX(gesture), y: offsetY), animated: true)
            }
        default:
            break
        }
    }
    
    
    private func calculateTargetOffsetX(_ gesture: UIPanGestureRecognizer) -> CGFloat {
        let direction: CGFloat = gesture.velocity(in: collectionView).x > 0 ? -1 : 1
        let nextIndex = max(0, min(allMenusVM.menus.value.count - 1, currentIndex + Int(direction)))
        let pageWidth = UIScreen.main.bounds.width - 20
        let targetOffsetX = CGFloat(pageWidth) * CGFloat(nextIndex)

        currentIndex = nextIndex
        
        return targetOffsetX
    }
    
    
    func configureFlowLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 20
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (padding * 2)
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.4)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        flowLayout.minimumLineSpacing = padding
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
