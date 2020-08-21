//
//  CollectionViewDemoViewController.swift
//  YCEmptyKitSwift_Example
//
//  Created by Xyy on 2020/8/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import YCEmptyKitSwift

class CollectionViewDemoViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 50)/3, height: (UIScreen.main.bounds.width - 50)/3)
        collectionLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.ycEmpty.delegate = self
        collectionView.ycEmpty.dataSource = self
        return collectionView
    }()
    
    var datas: [Int] = []
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addData))
        let removeBarItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeData))
        navigationItem.rightBarButtonItems = [removeBarItem, addBarItem]
    }
    
    /// 添加数据
    @objc func addData() {
        count += 1
        datas.append(count)
        collectionView.reloadData()
    }
    
    /// 移除数据
    @objc func removeData() {
        count = 0
        datas.removeAll()
        collectionView.reloadData()
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

extension CollectionViewDemoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.init(hue: 53/255.0, saturation: 49/255.0, brightness: 59/255.0, alpha: 1)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
}


extension CollectionViewDemoViewController: YCEmptyDataSource {
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        return UIImage(named: "refresh.png")
    }
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        return NSAttributedString(string: "转圈圈")
    }
    
    func descriptionForEmpty(in view: UIView) -> NSAttributedString? {
        return NSAttributedString(string: "爱的魔力转圈圈")
    }
    
    func horizontalSpaceForEmpty(in view: UIView) -> CGFloat {
        return 20
    }
    
    func imageAnimationForEmpty(in view: UIView) -> CAAnimation? {
        let rotateAni = CABasicAnimation(keyPath: "transform.rotation")
        rotateAni.fromValue = 0.0
        rotateAni.toValue = Double.pi * 2.0
        rotateAni.duration = 2
        rotateAni.repeatCount = MAXFLOAT
        return rotateAni
    }
    
    func prepareButtonForEmpty(in view: UIView, button: UIButton) {
        button.setBackgroundImage(getImageWithColor(color: UIColor(red: 136/255.0, green: 197/255.0, blue: 73/255.0, alpha: 1.0), size: CGSize(width: 200, height: 50)), for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setAttributedTitle(NSAttributedString(string: "旋转一下", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        button.setTitleColor(.red, for: .normal)
    }
    
    
}

extension CollectionViewDemoViewController: YCEmptyDelegate {
    
    func emptyView(_ emptyView: UIView, tappedIn view: UIView) {
        print("empty View taped")
    }
    
    func emptyButton(_ button: UIButton, tappedIn view: UIView) {
        print("empty Button taped")

    }
}



