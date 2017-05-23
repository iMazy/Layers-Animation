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
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

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
        
        
    }
}

