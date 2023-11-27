//
//  OneFloorController.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 12.11.2023.
//

import UIKit

final class OneFloorController: UIViewController {
    private enum Constants {
        static let collectionViewInsetTop: CGFloat = 70
        static let collectionViewInsetLeft: CGFloat = 35
        static let collectionViewInsetBottom: CGFloat = 10
        static let collectionViewInsetRight: CGFloat = 35
        static let collectionViewWidth: CGFloat = 161
        static let collectionViewHeight: CGFloat = 244
    }
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .FASBackgroundColor
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView?.register(for: ItemCell.self)
        view.addSubview(collectionView ?? UICollectionView())
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        
    }
}


extension OneFloorController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reusableIdentifier, for: indexPath)
        return myCell
    }
}

extension OneFloorController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        let destination = FridgeViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
    
}

extension OneFloorController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.collectionViewWidth, height: Constants.collectionViewHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.collectionViewInsetTop, left: Constants.collectionViewInsetLeft, bottom: Constants.collectionViewInsetBottom, right: Constants.collectionViewInsetRight)
    }
}
