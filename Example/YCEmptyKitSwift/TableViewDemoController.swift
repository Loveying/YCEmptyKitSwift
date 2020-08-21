//
//  TableViewDemoController.swift
//  YCEmptyKitSwift_Example
//
//  Created by Xyy on 2020/8/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import YCEmptyKitSwift

class TableViewDemoController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.ycEmpty.delegate = self
        tableView.ycEmpty.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var datas: [Int] = []
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        
        let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addData))
        let removeBarItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeData))
        navigationItem.rightBarButtonItems = [removeBarItem, addBarItem]
    }
    
    /// 添加数据
    @objc func addData() {
        count += 1
        datas.append(count)
        tableView.reloadData()
    }
    
    /// 移除数据
    @objc func removeData() {
        count = 0
        datas.removeAll()
        tableView.reloadData()
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

extension TableViewDemoController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(datas[indexPath.row])"
        return cell!
    }
    
}


extension TableViewDemoController: YCEmptyDataSource {
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        return UIImage(named: "file-empty.png")
    }
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        return NSAttributedString(string: "文件为空")
    }
    
    func descriptionForEmpty(in view: UIView) -> NSAttributedString? {
        return NSAttributedString(string: "旋转一下", attributes: [NSAttributedString.Key.foregroundColor : UIColor.green])
    }
    
    func horizontalSpaceForEmpty(in view: UIView) -> CGFloat {
        return 20
    }
    
    func prepareButtonForEmpty(in view: UIView, button: UIButton) {
        button.setBackgroundImage(getImageWithColor(color: .red, size: CGSize(width: 200, height: 50)), for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setAttributedTitle(NSAttributedString(string: "刷新一下", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        button.setTitleColor(.red, for: .normal)
    }
    
    
}

extension TableViewDemoController: YCEmptyDelegate {
    
    func emptyView(_ emptyView: UIView, tappedIn view: UIView) {
        print("empty View taped")
    }
    
    func emptyButton(_ button: UIButton, tappedIn view: UIView) {
        print("empty Button taped")

    }
}



