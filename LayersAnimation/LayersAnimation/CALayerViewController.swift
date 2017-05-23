//
//  CALayerViewController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/23.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CALayerViewController: UIViewController {

    @IBOutlet weak var viewForLayer: UIView!
    
    let layer = CALayer()
    let iconImage = UIImage(named: "horse")?.cgImage
    
    func setupLayer() {
        layer.frame = viewForLayer.bounds
        layer.contents =  iconImage
        layer.contentsGravity = kCAGravityCenter
        layer.isGeometryFlipped = false
        layer.cornerRadius =  100
        layer.borderWidth = 12.0
        layer.borderColor = UIColor.white.cgColor
        layer.backgroundColor = globalColor.cgColor
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3.0
        layer.magnificationFilter = kCAFilterLinear
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
