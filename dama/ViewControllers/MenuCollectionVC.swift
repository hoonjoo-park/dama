//
//  MenuCollectionVC.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import UIKit

private let reuseID = "MenuCell"

class MenuCollectionVC: UICollectionViewController {
    let padding: CGFloat = 25
    let deviceWidth = UIScreen.main.bounds.width
    
    var allMenusVM: AllMenusViewModel!
    var cartVM = CartViewModel.shared
    var identityX: CGFloat!
    var touchStartX: CGFloat!
    
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
        let lastIndex = allMenusVM.menus.value.count - 1
        let swipeDistance = deviceWidth - padding
        
        switch gesture.state {
        case .began:
            identityX = collectionView.contentOffset.x
            touchStartX = gesture.translation(in: collectionView).x
            break
            
        case .changed:
            let translationX = gesture.translation(in: collectionView).x
            collectionView.setContentOffset(CGPoint(x: identityX - translationX, y: offsetY), animated: false)
            break
            
        case .ended:
            let lastX = gesture.translation(in: collectionView).x
            let movedX = abs(touchStartX - lastX)
            
            if (movedX < threshold) {
                collectionView.setContentOffset(CGPoint(x: identityX, y: offsetY), animated: true)
                break
            }
            
            collectionView.setContentOffset(CGPoint(x: self.calculateTargetOffsetX(gesture, swipeDistance), y: offsetY), animated: true)
            
            let isEdge = cartVM.currentIndex.value == 0 || cartVM.currentIndex.value == lastIndex
            if isEdge { moveToRealSection(lastIndex, swipeDistance, offsetY) }
            
        default:
            break
        }
    }
    
    
    private func calculateTargetOffsetX(_ gesture: UIPanGestureRecognizer, _ swipeDistance: CGFloat) -> CGFloat {
        let direction: CGFloat = gesture.velocity(in: collectionView).x > 0 ? -1 : 1
        let nextIndex = max(0, min(allMenusVM.menus.value.count - 1, cartVM.currentIndex.value + Int(direction)))
        let targetOffsetX = CGFloat(swipeDistance) * CGFloat(nextIndex)
        
        cartVM.setCurrentMenu(nextIndex)
        
        return targetOffsetX
    }
    
    
    private func moveToRealSection(_ lastIndex: Int, _ swipeDistance: CGFloat, _ offsetY: CGFloat) {
        let maxOffsetX = swipeDistance * CGFloat(lastIndex - 1)
        let nextIndex = cartVM.currentIndex.value == 0 ? lastIndex - 1 : 1
        let targetOffsetX = cartVM.currentIndex.value == 0 ? maxOffsetX : swipeDistance
        
        cartVM.setCurrentMenu(nextIndex)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [self] in
            collectionView.setContentOffset(CGPoint(x: targetOffsetX, y: offsetY), animated: false)
        }
    }
    
    
    func configureFlowLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let cellWidth = deviceWidth - (padding * 2)
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.3)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        flowLayout.minimumLineSpacing = padding
        flowLayout.minimumInteritemSpacing = 0
        
        return flowLayout
    }
    
    
    private func fetchMenus() {
        Task {
            do {
                let menus = try await WebService.shared.fetchMenus()
                let appendedMenus = [menus[menus.count-1]] + menus + [menus[0]]
                
                allMenusVM = AllMenusViewModel(appendedMenus)
                cartVM.setCart(menus: appendedMenus)
                collectionView.reloadData()
            }
            catch { throw ErrorMessages.InvalidData }
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    
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
