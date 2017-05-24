//
//  ScrollingView.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/24.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import QuartzCore

class ScrollingView: UIView {

    override class var layerClass: AnyClass {
        return CAScrollLayer.self
    }

}
