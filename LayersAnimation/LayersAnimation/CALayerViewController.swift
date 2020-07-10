//
//  CALayerViewController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/23.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CALayerViewController: UIViewController {

    /// 存放 layer 的 view
    @IBOutlet weak var viewForLayer: UIView!
    
    /// 自己的 Layer
    let layer = CALayer()
    /// 给 layer 添加内容,这里是图片
    let iconImage = UIImage(named: "horse")?.cgImage
    
    /// 设置 layer 属性
    func setupLayer() {
        layer.frame = viewForLayer.bounds
        layer.contents =  iconImage
        layer.contentsGravity = CALayerContentsGravity.center
        layer.isGeometryFlipped = false
        layer.cornerRadius =  100
        layer.borderWidth = 12.0
        layer.borderColor = UIColor.white.cgColor
        layer.backgroundColor = globalColor.cgColor
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3.0
        layer.magnificationFilter = CALayerContentsFilter.linear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayer()
        viewForLayer.layer.addSublayer(layer)
        
    }
    
    // 传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DisplayLayerControls" {
            (segue.destination as! CALayerControlsController).layerViewController = self
        }
    }

}
