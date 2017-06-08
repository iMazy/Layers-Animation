//
//  CATiledImageLayerController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/6/8.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CATiledImageLayerController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tilingView: TilingViewForImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "CATiledLayer (image)"
        scrollView.contentSize = CGSize(width: 5120, height: 2880)
    }
    

}
