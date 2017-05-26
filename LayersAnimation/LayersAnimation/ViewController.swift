//
//  ViewController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    /// 数组中存放元祖 title and subTitle
    var classes: [(String, String)] {
        get {
            return [
                ("CALayer", "Manage and animate visual content"),
                ("CAScrollLayer", "Display portion of a scrollable layer"),
                ("CATextLayer", "Render plain text or attributed strings"),
                ("AVPlayerLayer", "Display an AV player "),
                ("CAGradientLayer", "Apply a color gradient over the background"),
                ("CAReplicatorLayer", "Duplicate a source layer"),
                ("CATiledLayer", "Asynchronously draw layer content in tiles"),
                ("CAShapeLayer", "Draw using scalable vector paths"),
                ("CAEAGLLayer", "Draw OpenGL content"),
                ("CATransformLayer", "Draw 3D structures"),
                ("CAEmitterLayer", "Render animated particles")
            ]
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 取消底部多余的分割线
        tableView.tableFooterView = UIView()
        // 设置默认 cell 的高度
        tableView.rowHeight = 64
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // 让下一级页面的返回按钮只显示图标
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }

}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell")!
        let row = indexPath.row
        cell.textLabel?.text = classes[row].0
        cell.detailTextLabel?.text = classes[row].1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let identifier = classes[indexPath.row].0
        let targetVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        targetVC.title = identifier
        navigationController?.show(targetVC, sender: nil)
    }
}

